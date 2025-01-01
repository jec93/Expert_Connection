package kr.or.iei.chat.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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

import kr.or.iei.chat.model.service.ChatMemberService;
import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.chat.model.vo.Room;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("chatMemberService")
	private ChatMemberService chatMemberService;
	
	//채팅방 목록 조회
	@GetMapping("/getRoomList.exco")
	public String getRoomList(Model model, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberNo = loginMember.getMemberNo();
		
		ArrayList<Room> roomList = chatService.getRoomList(loginMember.getMemberNo());
		model.addAttribute("roomList", roomList);	
		
		return "chat/roomList";
	}
	
	
	//현재 방 기존 채팅 정보
	@GetMapping(value="/getChatList.exco")
	public String goChat(Model model, String roomId) {
		ArrayList<Chat> chatList = chatService.getChatList(roomId);
		List<Member> memberList = chatMemberService.getRoomMembers(roomId);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("roomId", roomId);
		model.addAttribute("chatList", chatList);
		
		return "chat/chat";
	}
	
	//메시지 송신 이전, 파일 업로드
	@PostMapping(value="/fileUpload.exco", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String fileUpload(HttpServletRequest request, MultipartFile file) {
		Chat chat = null;
		
		if(!file.isEmpty()) {

			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/");
			String originalFilename = file.getOriginalFilename();
			String fileName = originalFilename.substring(0, originalFilename.lastIndexOf("."));
			String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
			
			//서버 업로드 파일명 중복되지 않도록
			String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
			int ranNum = new Random().nextInt(100000) +1;
			String filePath = fileName + "_" + toDay + "_" + ranNum + extension;
			
			savePath += filePath;
			
			try {
				byte[] bytes = file.getBytes();
				BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(savePath)));
				bos.write(bytes);
				bos.close();
				
				chat = new Chat();
				chat.setFileName(originalFilename);
				chat.setFilePath(filePath);
				
				//result = service.insertChatFile(chat);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return new Gson().toJson(chat);
	}
	
	//파일 다운
	@GetMapping(value="/fileDown.exco", produces = "application/octet-stream;")
	public void noticeFileDown(HttpServletRequest request, HttpServletResponse response, String fileName, String filePath) {
		  
		  String root = request.getSession().getServletContext().getRealPath("/resources/upload/");
		
	    
		  BufferedInputStream bis = null;
		  BufferedOutputStream bos = null;
		  
	      try {
	         FileInputStream fis = new FileInputStream(root + filePath);
	         
	         bis = new BufferedInputStream(fis);
	         
	         ServletOutputStream sos = response.getOutputStream();
	         
	         bos = new BufferedOutputStream(sos);
	         
	         String resFilename = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	         
	         response.setHeader("Content-Disposition", 
	        		 "attachment; filename="+resFilename);
	         
	         while(true) {
				int read = bis.read();
				if(read == -1) {
					break;
				}else {
					bos.write(read);
				}
			}
	         
	         
	      } catch (FileNotFoundException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      } catch (IOException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      } finally {
	    	  try {
	    		  bos.close();
	    		  bis.close();
	    	  } catch (IOException e) {
	    		  // TODO Auto-generated catch block
	    		  e.printStackTrace();
	    	  }
	      }
	}
	
	//방 만들기 페이지 이동
	@GetMapping("/createRoomFrm.exco")
	public String createRoomFrm(Model model) {
		ArrayList<Member> memberList =  chatMemberService.selectMemberList();
		model.addAttribute("memberList", memberList);
		
		return "chat/createRoom";
	}
	
	//방 만들기
	@GetMapping("/createRoom.exco")
	@ResponseBody
	public String createRoom(HttpSession session, String roomName, String members) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		String roomId = chatService.createRoom(roomName, loginMember.getMemberNo(), members);
				
		return roomId;
	}
	
	//방 숨기기
	@PostMapping("/hideRoom.exco")
	@ResponseBody
	public String hideRoom(String roomId, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberNo = loginMember.getMemberNo();
		
		int result = chatService.updateHiddenStatus(roomId, memberNo, true); //특정 사용자에 대해 숨김 처리
		
		return result > 0 ? "success" : "fail";
	}
	
	
	//방 나가기 - 일단 남겨두지만 추후에 상황보고 삭제 ㄱㄱ
	@GetMapping("/deleteChat.exco")
	public String deleteChat(Chat chat) {
		
		int result = chatService.deleteRoom(chat);
		
		return "redirect:/chat/getRoomList.exco";
	}
}
