package kr.or.iei.payment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@GetMapping("/goChat.exco")
	@ResponseBody
	public String createRoomAndRedirect(HttpSession session, String roomName, String members) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		// 기존 채팅방이 있는지 확인
	    String existingRoomId = chatService.findExistingRoom(loginMember.getMemberNo(), members);
	    if (existingRoomId != null) {
	        return existingRoomId; // 기존 채팅방 ID 반환
	    }
	    
		String roomId = chatService.createRoom(roomName, loginMember.getMemberNo(), members);
				
		return roomId;
	}
	
}
