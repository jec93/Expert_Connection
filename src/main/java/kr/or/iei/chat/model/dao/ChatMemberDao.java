package kr.or.iei.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.vo.Member;

@Repository("chatMemberDao")
public class ChatMemberDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	public ChatMemberDao() {
		super();
	}
	public Member selectOneMember(Member m) {		
		return sqlSession.selectOne("chatMember.selectOneMember", m);
	}
	public List<Member> selectMemberList() {
		return sqlSession.selectList("chatMember.selectMemberList");
	}

	//방에 참여한 멤버 조회
	public List<Member> selectRoomMembers(String roomId) {
        return sqlSession.selectList("chatMember.selectRoomMembers", roomId);
    }
}
