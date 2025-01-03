package kr.or.iei.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.member.model.service.MemberService;


@Component("socketHandler")
public class SocketHandler extends TextWebSocketHandler{
	
	@Autowired
	@Qualifier("chatService")
	private ChatService service;
	
	private ArrayList<WebSocketSession> members;
	private HashMap<String, WebSocketSession> map;
	
	public SocketHandler() {
		members = new ArrayList<WebSocketSession>();
		map = new HashMap<String, WebSocketSession>();
	}
	
	//소켓이 생성되어 연결되었을 때 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결 성공");
		members.add(session); //신규 접속자 정보 저장
	}
	
	
	//메세지를 송신 시 동작하는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//수신 받은 메시지 형식 == Json 형식 => 파싱 처리
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(message.getPayload());
		JsonObject jsonObj = element.getAsJsonObject();
		String type= jsonObj.get("type").getAsString();
		
		if(type.equals("connect")) {
			//최초 연결 시, 연결 정보 등록
			String memberNo = jsonObj.get("memberNo").getAsString();
			map.put(memberNo, session);	
			
		}else if(type.equals("chat")) {
			//메시지 송신
			String roomId   = jsonObj.get("roomId").getAsString();
			String memberNo = jsonObj.get("memberNo").getAsString();
			String memberNickname = jsonObj.get("memberNickname").getAsString(); // 전문가 닉네임
			String msg      = jsonObj.get("msg").getAsString();
			String fileName = jsonObj.get("fileName") != null ? jsonObj.get("fileName").getAsString() : null;
			String filePath = jsonObj.get("filePath") != null ? jsonObj.get("filePath").getAsString() : null;
			
			Chat chat = new Chat();
			chat.setRoomId(roomId);
			chat.setMemberNo(memberNo);
			chat.setMsg(msg);
			chat.setMsgGb(filePath != null ? "1" : "0");
			chat.setFileName(fileName);
			chat.setFilePath(filePath);
			
			//DB 등록
			int result = service.insertChat(chat);
			
			if(result > 0) {
				
				 // 메시지를 수신한 모든 사용자에 대해 숨김 상태를 해제
                List<String> recipientIds = service.getRecipientIdsByRoomId(roomId);
                for (String recipientId : recipientIds) {
                    if (!recipientId.equals(memberNo)) { // 발신자는 제외
                        service.updateHiddenStatusForUser(roomId, recipientId, false); // 숨김 상태 해제
                    }
                }
		        
		     // 클라이언트에 메시지 전송
		        JsonObject response = new JsonObject();
		        response.addProperty("type", "chat");
		        response.addProperty("roomId", roomId);
		        response.addProperty("memberNo", memberNo); 
		        response.addProperty("isHidden", false);
		        response.addProperty("fileName", fileName); // 파일 이름 추가
		        response.addProperty("filePath", filePath); // 파일 경로 추가
		        response.addProperty("msg", msg);
		        response.addProperty("memberNickname", memberNickname);
		        
		        
		        this.sendMsg(response.toString());
				
				/*
				 * //파일 등록 시, 다운로드 가능하도록 텍스트 처리 if(filePath != null) { msg =
				 * "<a href='javascript:void(0)' onclick='fn.chatFileDown(\"" + fileName +
				 * "\", \"" + filePath + "\")'>" + fileName + "</a> " + msg; }
				 */
			}
		} else if (type.equals("autoResponse")) {
	        // 자동응답 메시지 처리
	        handleAutoResponseMessage(jsonObj);
	    }
	}
	
	private void handleAutoResponseMessage(JsonObject jsonObj) {
	    String roomId = jsonObj.get("roomId").getAsString();
	    String memberNo = jsonObj.get("memberNo").getAsString(); // 전문가의 회원 번호
	    String msg = jsonObj.get("msg").getAsString();
	    String memberNickname = jsonObj.get("memberNickname").getAsString(); // 전문가 닉네임
	    
	    // 메시지를 채팅 테이블에 저장
	    Chat chat = new Chat();
	    chat.setRoomId(roomId);
	    chat.setMemberNo(memberNo);
	    chat.setMsg(msg);
	    chat.setMsgGb("0"); // 일반 메시지
	    chat.setFileName(null);
	    chat.setFilePath(null);

	    int result = service.insertChat(chat);

	    if (result > 0) {
	        // 모든 사용자에게 메시지 브로드캐스트
	        JsonObject response = new JsonObject();
	        response.addProperty("type", "chat");
	        response.addProperty("roomId", roomId);
	        response.addProperty("memberNo", memberNo); // 전문가의 회원 번호
	        response.addProperty("msg", msg);
	        response.addProperty("memberNickname", memberNickname);

	        this.sendMsg(response.toString());
	    }
	}

	
	//연결된 사용자들에게 메세지 전송
	public void sendMsg(String msg) {
		Set<String> set = map.keySet();
		Iterator<String> keys = set.iterator();
		
		while(keys.hasNext()) {
			String key = keys.next();
			WebSocketSession ws = map.get(key);
			
			if(ws != null) {				
				try {
					ws.sendMessage(new TextMessage(msg));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	
	//연결 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결 종료");
		members.remove(session);
	}
}
