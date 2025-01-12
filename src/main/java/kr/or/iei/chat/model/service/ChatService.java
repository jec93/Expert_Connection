package kr.or.iei.chat.model.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.chat.model.dao.ChatDao;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.chat.model.vo.Room;
import kr.or.iei.member.model.vo.Member;

@Service("chatService")
public class ChatService {
	
	@Autowired
	@Qualifier("chatDao")
	private ChatDao chatDao;

	public ArrayList<Room> getRoomList(String memberNo) {
		return (ArrayList<Room>) chatDao.getRoomList(memberNo);
	}

	public ArrayList<Chat> getChatList(String roomId) {
		return (ArrayList<Chat>) chatDao.getChatList(roomId);
	}

	public int insertChat(Chat chat) {
		return chatDao.insertChat(chat);
	}
	
	@Transactional
	public String createRoom(String roomName, String createNo, String members) {
		String roomId = chatDao.getRoomId(); //방 번호 조회
		
		Room room = new Room();
		room.setRoomId(roomId);
		room.setRoomName(roomName);
		room.setCreateNo(createNo);
		
		//채팅방 개설
		if(chatDao.insertRoom(room) > 0) {
			members +=","+createNo;
			List<String> memberList = Arrays.asList(members.split(","));
			
			//채팅방 참여자 관리 정보 등록
			for(int i=0; i<memberList.size(); i++) {
				room.setCreateNo(memberList.get(i));
				chatDao.insertChatMember(room);
			}
			
			return roomId;
		}else {
			return null;
		}
	}
	
	public int deleteRoom(Chat chat) {
		return chatDao.deleteRoom(chat);
	}

	// 숨김 상태 업데이트
	public int updateHiddenStatus(String roomId, String memberNo, boolean isHidden) {
		return chatDao.updateHiddenStatus(roomId, memberNo, isHidden);
	}

	// 숨김 상태 반환
	public boolean isRoomHidden(String roomId) {
		String isHidden = chatDao.getRoomHiddenStatus(roomId);
		return "Y".equals(isHidden);
	}
	
	// 숨김 상태 업데이트(수신자들! 근데 이거 굳이 필요한가..? 잘모르겠다.. 위에거랑 넘 비슷한데...)
	public void updateHiddenStatusForUser(String roomId, String memberNo, boolean isHidden) {
		chatDao.updateHiddenStatusForUser(roomId, memberNo, isHidden);
	}

	//특정 채팅방에 참여중인 사용자 id 들 목록
	public List<String> getRecipientIdsByRoomId(String roomId) {
		return chatDao.getRecipientIdsByRoomId(roomId);
	}

	// 기존 채팅방 조회
	public String findExistingRoom(String memberNo, String otherMemberNo) {
		return chatDao.findRoomByMembers(memberNo, otherMemberNo);
	}

	// 실시간 채팅 멤버 각 프로필 가져오기
	public Member getMemberProfile(String memberNo) {
		return chatDao.getMemberProfile(memberNo);
	}
}
