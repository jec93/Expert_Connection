package kr.or.iei.chat.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.or.iei.chat.model.service.ChatMemberService;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/member")
public class ChatMemberController {
	
	@Autowired
	@Qualifier("chatMemberService")
	private ChatMemberService chatMemberService;
	
	public ChatMemberController(){
		super();
	}
	
	//로그인
	@PostMapping(value="/login.do") //jsp 요청과 매핑
	public String loginMember(HttpSession session, Member member) {
		Member loginMember = chatMemberService.selectOneMember(member);
		
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		}else {
			return "member/loginFail";	
		}
	}
	
	//로그아웃
	@GetMapping(value="/logout.do")
	public String logout(HttpSession session) {
		//세션 파기
		session.invalidate();
		
		return "redirect:/";
	}
	
}
