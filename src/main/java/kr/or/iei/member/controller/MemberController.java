package kr.or.iei.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/member/")
public class MemberController {

	@Autowired
	@Qualifier("service")
	private MemberService memberService;
	
	@PostMapping("login.exco")
	public String memberLogin(Member member, HttpSession session) {
		Member loginMember = memberService.memberLogin(member);
		
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		}else {
			return "member/loginFail";
		}

	}
	
	
	@GetMapping("logout.exco")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	@GetMapping("loginFrm.exco")
	public String loginFrm() {
		return "member/login";
	}
	
	@GetMapping("joinFrm.exco")
	public String joinFrm() {
		return "member/join";
	}
	
	@PostMapping("join.exco")
	public String join(Member member) {
		
		int result = memberService.join(member);
		
		if(result > 0) {
			return "redirect:/";
		}else {
			return "member/joinFail";
		}
	}
	
	@GetMapping("idDuplChk.exco")
	@ResponseBody
	public String idDuplChk(String memberId) {
		
		int cnt = memberService.idDuplChk(memberId);
		
		return String.valueOf(cnt);				
	}
	

}
	

