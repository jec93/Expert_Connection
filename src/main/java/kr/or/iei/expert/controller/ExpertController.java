package kr.or.iei.expert.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.iei.expert.model.service.ExpertService;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.member.model.vo.Member;

@Controller("expertController")
@RequestMapping("/expert")
public class ExpertController {

	@Autowired
    private ExpertService expertService;
	
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
	public String searchExperts(String categoryNm, String addr, Model model) {
		List<ExpertIntroduce> experts = expertService.findExpertsByCategory(categoryNm, addr);	
		model.addAttribute("experts", experts);
		
	    return "member/expertBotSearchTest";
	}
	
	//전문가 상세페이지 정보 업데이트
	@PostMapping("/expertUpdateContent.exco")
	@ResponseBody
	public String expertUpdateContent(String title, String content, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		if(loginMember == null) {
			return "redirect:/";
		}
		
		// 전문가 본인인지 확인
        boolean isUpdated = expertService.updateExpertContent(loginMember.getMemberNo(), title, content);

        return isUpdated ? "success" : "fail";
	}
	
	//전문가 상세페이지 포트폴리오 파일 업로드
	@PostMapping(value = "/expertUpdatePortfolio.exco", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String expertUpdatePortfolio(HttpServletRequest request, MultipartFile file, String memberNo, String fileName, String filePath) {
	    Member loginMember = (Member) request.getSession().getAttribute("loginMember");
	    if (loginMember == null || !loginMember.getMemberNo().equals(memberNo)) {
	        return new Gson().toJson("unauthorized"); // 로그인 정보가 없거나, 본인 계정이 아닌 경우 차단
	    }

	    String savePath = request.getSession().getServletContext().getRealPath("/resources/portfolio/");
	    String uploadedFilePath = null;
	    
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
	            return new Gson().toJson("upload_fail");
	        }
	    } else {
	        uploadedFilePath = filePath; // 기존 파일을 유지할 경우
	    }

	    // DB에 저장할 객체 생성
	    ExpertIntroduce portfolio = new ExpertIntroduce();
	    portfolio.setMemberNo(memberNo);
	    portfolio.setExpertFileName(fileName);
	    portfolio.setExpertFilePath(uploadedFilePath);

	    // DB 업데이트 실행
	    boolean isUpdated = expertService.updatePortfolio(portfolio);

	    return new Gson().toJson(isUpdated ? "success" : "db_fail");
	}

	
	/*
	 * //전문가 상세페이지 포트폴리오 파일 다운
	 * 
	 * @GetMapping(value = "/portfolioDownload.exco", produces =
	 * "application/octet-stream;") public void fileDownload(HttpServletRequest
	 * request, HttpServletResponse response, String memberNo) {
	 * 
	 * // DB에서 파일 정보 가져오기 ExpertIntroduce portfolio =
	 * expertService.getPortfolioFile(memberNo);
	 * 
	 * if (portfolio == null) {
	 * response.setStatus(HttpServletResponse.SC_NOT_FOUND); return; }
	 * 
	 * String fileName = portfolio.getExpertFileName(); String filePath =
	 * portfolio.getExpertFilePath(); String root =
	 * request.getSession().getServletContext().getRealPath("/resources/upload/");
	 * 
	 * BufferedInputStream bis = null; BufferedOutputStream bos = null;
	 * 
	 * try { File file = new File(root + filePath); if (!file.exists()) {
	 * response.setStatus(HttpServletResponse.SC_NOT_FOUND); return; }
	 * 
	 * FileInputStream fis = new FileInputStream(file); bis = new
	 * BufferedInputStream(fis); ServletOutputStream sos =
	 * response.getOutputStream(); bos = new BufferedOutputStream(sos);
	 * 
	 * String resFilename = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	 * response.setHeader("Content-Disposition", "attachment; filename=" +
	 * resFilename);
	 * 
	 * int read; while ((read = bis.read()) != -1) { bos.write(read); }
	 * 
	 * } catch (IOException e) { e.printStackTrace(); } finally { try { if (bos !=
	 * null) bos.close(); if (bis != null) bis.close(); } catch (IOException e) {
	 * e.printStackTrace(); } } }
	 */
}
