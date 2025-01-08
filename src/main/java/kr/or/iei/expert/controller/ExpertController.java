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
import kr.or.iei.member.model.vo.Member;

@Controller("expertController")
@RequestMapping("/expert")
public class ExpertController {

	@Autowired
    private ExpertService expertService;
	
	@Autowired
	@Qualifier("categoryService")
	private CategoryService categoryService;
	
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
	public String searchExperts(String keywords, String addr, Model model) {
		List<ExpertIntroduce> srchList = categoryService.searchExperts(keywords);
		if(srchList==null) {
    		model.addAttribute("title", "정보");
    		model.addAttribute("msg", "검색 결과 없음.");
    		model.addAttribute("icon", "info");
    		model.addAttribute("loc", "/expert/expertBotSearchFrm.exco");
    		return "common/msg";
    	}
		//검색 결과를 주소로 필터
		List<ExpertIntroduce> resultList = new ArrayList<ExpertIntroduce>();
		for(ExpertIntroduce e: srchList) {
			if(e.getExpertAddr().equals(addr)) {
				resultList.add(e);
			}
		}
		model.addAttribute("keyword",keywords);
    	model.addAttribute("srchList",resultList);
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

}
