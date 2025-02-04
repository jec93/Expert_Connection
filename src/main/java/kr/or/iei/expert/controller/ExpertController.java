package kr.or.iei.expert.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.iei.category.model.service.CategoryService;
import kr.or.iei.expert.model.service.ExpertService;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.expert.model.vo.Review;
import kr.or.iei.member.model.vo.Member;

@Controller("expertController")
@RequestMapping("/expert")
public class ExpertController {

	@Autowired
    private ExpertService expertService;
	
	@Autowired
	@Qualifier("categoryService")
	CategoryService categoryService;
	
	//회원 번호로 전문가 소개 페이지 불러오기
	@GetMapping("/viewExpertInfoByMemberNo.exco")
	public String viewExpertInfoByMemberNo(String memberNo, Model model ) {
		ExpertIntroduce expertDetail = expertService.viewExpertInfoByMemberNo(memberNo);
		model.addAttribute("expertDetail",expertDetail);
		return "member/expertDetail";
	}
	
	@GetMapping("/expertBotSearchFrm.exco")
	public String expertBotSearchFrm() {
		return "member/expertBotSearch";
	}
	
	//챗봇 전문가 추천
	@GetMapping("/expertBotSearch.exco")
	public String searchExperts(String keyword, String addr, Model model) {
		ArrayList<ExpertIntroduce> srchList = categoryService.searchExperts(keyword);
    	if(srchList==null) {
    		model.addAttribute("title", "정보");
    		model.addAttribute("msg", "검색 결과 없음.");
    		model.addAttribute("icon", "info");
    		return "common/msg";
    	}
    	
    	ArrayList<ExpertIntroduce> filteredList = new ArrayList<ExpertIntroduce>();
    	for(ExpertIntroduce i : srchList){
    		if(i.getExpertAddr().contains(addr)) {
    			filteredList.add(i);
    		}
    	}
    	
    	model.addAttribute("keyword",keyword);
    	model.addAttribute("srchList",filteredList);
    	return"/categories/srchResult";
	}
	
	//전문가 상세페이지 정보 업데이트
	@PostMapping("/expertUpdateContent.exco")
	@ResponseBody
	public Map<String, String> expertUpdateContent(String title, String content, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		Map<String, String> response = new HashMap<>();
		
		if(loginMember == null) {
			response.put("status", "fail");
	        response.put("message", "로그인이 필요합니다.");
	        return response;
		}
		
		// 전문가 본인인지 확인
        boolean isUpdated = expertService.updateExpertContent(loginMember.getMemberNo(), title, content);

        if (isUpdated) {
            response.put("status", "success");
        } else {
            response.put("status", "fail");
            response.put("message", "업데이트 실패");
        }
        
        return response; // JSON 형식 응답
	}
	
	//전문가 상세페이지 포트폴리오 파일 업로드
	@PostMapping(value = "/expertUpdatePortfolio.exco", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, String> expertUpdatePortfolio(HttpServletRequest request, MultipartFile file, String memberNo, String fileName, String filePath) {
	    Map<String, String> response = new HashMap<>();
		
	    Member loginMember = (Member) request.getSession().getAttribute("loginMember");
	    
	    if (loginMember == null || !loginMember.getMemberNo().equals(memberNo)) {
	        response.put("status", "unauthorized");
	        return response;
	    }

	    String savePath = request.getSession().getServletContext().getRealPath("/resources/portfolio/");
	    String uploadedFilePath = filePath;
	    
	    if (file != null && !file.isEmpty()) { // 파일이 업로드된 경우에만 처리
	        String originalFilename = file.getOriginalFilename();
	        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	        String newFileName = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date()) + "_" + new Random().nextInt(100000) + fileExtension;
	        File saveFile = new File(savePath, newFileName);

	        try {
	            file.transferTo(saveFile);
	            uploadedFilePath = "/resources/portfolio/" + newFileName;
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	            response.put("status", "upload_fail");
	            return response;
	        }
	    } else {
	    	 response.put("fileUrl", filePath);
	    }

	    // DB에 저장할 객체 생성
	    ExpertIntroduce portfolio = new ExpertIntroduce();
	    portfolio.setMemberNo(memberNo);
	    portfolio.setExpertFileName(fileName);
	    portfolio.setExpertFilePath(uploadedFilePath);

	    // DB 업데이트 실행
	    boolean isUpdated = expertService.updatePortfolio(portfolio);

	    response.put("status", isUpdated ? "success" : "db_fail");
	    response.put("fileUrl", uploadedFilePath);
	    response.put("fileName", fileName);
	    return response;
	}
	@GetMapping("/insertReview")
	public String insertReview(Review review, Model model) {
		System.out.println(review);
		int result = expertService.insertReview(review);
		if(result>0) {
			model.addAttribute("title","리뷰작성!");
			model.addAttribute("text","당신의 소중한 리뷰 감사합니다.");
			model.addAttribute("icon","success");
		}else {
			model.addAttribute("title","작성 실패");
			model.addAttribute("text","리뷰작성 실패");
			model.addAttribute("icon","error");
		}
		return "common/msg";
	}
	
	@GetMapping("/deleteReview.exco")
	public String deleteReview(String reviewNo, Model model) {
		int result = expertService.deleteReview(reviewNo);
		if(result>0) {
			model.addAttribute("title","삭제성공");
			model.addAttribute("text","요청하신 리뷰가 삭제되었습니다.");
			model.addAttribute("icon","success");
		}else {
			model.addAttribute("title","삭제실패");
			model.addAttribute("text","리뷰 삭제중 에러");
			model.addAttribute("icon","error");
		}
		return "common/msg";
	}
	
	@GetMapping("/getIntroStatus.exco")
	@ResponseBody
	public Map<String, Object> getIntroStatus(String introNo, String memberNo) {
		//전문가 좋아요 상태를 가져오는 서비스 호출
		String introReact = expertService.getReviewReaction(introNo, memberNo);
		System.out.println("리뷰 상태 넘어온 값" + introReact);
		Map<String, Object> response = new HashMap<String, Object>();
		if(introReact != null) {
			response.put("introReact", introReact);
			response.put("status", "success");
		}else {
			response.put("introReact", "0");
			response.put("status", "error");
			response.put("message", "좋아요 상태를 가져오는데 실패했습니다.");
		}
		return response;
	}
	
	@GetMapping(value="updIntroLike.exco", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String, String> updIntroLike(String introNo, String memberNo,String expertNo, int like) {
        String[] result = expertService.updReviewLike(introNo, memberNo, expertNo, like);
        Map<String, String> response = new HashMap<String, String>();
        
        if (Integer.parseInt(result[0]) > 0) {
            response.put("introReact", result[2]);
            response.put("message", result[1]);
        } else {
            response.put("introReact", "0");
            response.put("message", "0");
        }
        return response;
    }
}
