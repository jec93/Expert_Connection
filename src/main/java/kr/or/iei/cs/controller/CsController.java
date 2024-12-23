package kr.or.iei.cs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("csController")
@RequestMapping("/cs/")
public class CsController {

	//고객센터 메인페이지 이동
	@GetMapping("CS.exco")
	public String Cs() {
		return "cs/csMain";
	}
	
	//전문가회원 승인절차 안내 페이지로 이동
	@GetMapping("introExpertProcess.exco")
	public String introExpertProcess(){
		return "cs/introExpertProcess";
	}
	
	//사이트 소개 페이지 이동
	@GetMapping("siteIntro.exco")
	public String siteIntro() {
		return "cs/siteIntro";
	}
	
	//이용약관 페이지 이동
	@GetMapping ("siteTermsOfUse.exco")
	public String siteTermsOfUse() {
		return "cs/siteTermsOfUse";
	}
	
	//개인정보처리방침 페이지 이동
	@GetMapping ("personalInfoPolicy.exco")
	public String personalInfoPolicy() {
		return "cs/personalInfoPolicy";
	}
	
	//사용자 사이트 이용 가이드 페이지 이동
	@GetMapping ("introduceMember.exco")
	public String introduceMember() {
		return "cs/introduceMember";
	}
	
	//전문가 사이트 이용 가이드 페이지 이동
	@GetMapping ("introduceExpert.exco")
	public String introduceExpert() {
		return "cs/introduceExpert";
	}
}
