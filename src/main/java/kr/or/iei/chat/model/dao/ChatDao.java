package kr.or.iei.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.chat.model.vo.Room;

@Repository("chatDao")
public class ChatDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public List<Room> getRoomList(String memberNo) {
		return sqlSession.selectList("chat.getRoomList", memberNo);
	}

	public List<Chat> getChatList(String roomId) {
		return sqlSession.selectList("chat.getChatList", roomId);
	}

	public int insertChat(Chat chat) {
		return sqlSession.insert("chat.insertChat", chat);
	}

	public String getRoomId() {
		return sqlSession.selectOne("chat.getRoomId");
	}

	public int insertRoom(Room room) {
		return sqlSession.insert("chat.insertRoom", room);
	}

	public int insertChatMember(Room room) {
		return sqlSession.insert("chat.insertChatMember", room);
	}

	public int deleteRoom(Chat chat) {
		return sqlSession.update("chat.deleteRoom", chat);
	}

	//숨김 상태 업데이트
	public int updateHiddenStatus(String roomId, String memberNo, boolean isHidden) {
		
		System.out.println("roomID : " + roomId);
		System.out.println("memberNo : " + memberNo);
		System.out.println("isHidden : " + isHidden);
		Map<String, Object> params = new HashMap<>();
		params.put("roomId", roomId);
		params.put("memberNo", memberNo);
		params.put("isHidden", isHidden ? "Y" : "N");
		return sqlSession.update("chat.updateHiddenStatus", params);
	}

	//숨김 상태 반환
	public String getRoomHiddenStatus(String roomId) {
		//Mapper 호출
		return sqlSession.selectOne("chat.getRoomHiddenStatus", roomId);
	}

	// 유저들 숨김 상태 업데이트? (받는 사람)
	public void updateHiddenStatusForUser(String roomId, String memberNo, boolean isHidden) {
		Map<String, Object> params = new HashMap<>();
	    params.put("roomId", roomId);
	    params.put("memberNo", memberNo);
	    params.put("isHidden", isHidden ? "Y" : "N");
	    sqlSession.update("chat.updateHiddenStatus", params);
	}

	public List<String> getRecipientIdsByRoomId(String roomId) {
		return sqlSession.selectList("chat.getRecipientIdsByRoomId", roomId);
	}

	public String findRoomByMembers(String memberNo, String otherMemberNo) {
		Map<String, String> params = new HashMap<>();
		params.put("memberNo", memberNo);
		params.put("otherMemberNo", otherMemberNo);
		return sqlSession.selectOne("chat.findRoomByMembers", params);
	}
}
