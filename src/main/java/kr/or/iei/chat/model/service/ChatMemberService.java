package kr.or.iei.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.chat.model.dao.ChatMemberDao;
import kr.or.iei.member.model.vo.Member;

@Service("chatMemberService")
public class ChatMemberService {
	
	@Autowired
	@Qualifier("chatMemberDao")
	private ChatMemberDao chatMemberDao;
	
	public ChatMemberService() {
		super();
	}

	public Member selectOneMember(Member m) {
		return chatMemberDao.selectOneMember(m);
	}
	
	public ArrayList<Member> selectMemberList(){
		return (ArrayList<Member>) chatMemberDao.selectMemberList();
	}

	//방에 참여한 멤버 조회
	public List<Member> getRoomMembers(String roomId) {
        return chatMemberDao.selectRoomMembers(roomId);
    }
}
