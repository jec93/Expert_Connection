package kr.or.iei.member.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.vo.Expert;
import kr.or.iei.member.model.vo.Member;

@Repository("dao")
public class MemberDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	public Member memberLogin(Member member) {
		return sqlSession.selectOne("member.selectOneMember", member);
	}
	public Expert expertLogin(Expert expert) {
		return sqlSession.selectOne("member.selectOneExpert", expert);
	}

	public int join(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}
	
	public int joinWholeMember(Member member) {
		return sqlSession.insert("member.insertWholeMember", member);
	}
	
	public int idDuplChk(String memberId) {		
		return sqlSession.selectOne("member.idDuplChk", memberId);
	}

	public String selectMemberNo() {
		return sqlSession.selectOne("member.selectMemberNo");
	}

	public int nickDuplChk(String memberNickname) {
		return sqlSession.selectOne("member.nickDuplChk", memberNickname);
	}
	
	public int deleteMember(String memberNo) {
        return sqlSession.delete("member.deleteMember", memberNo);
    }
	
	public int checkPassword(Member member) {
        return sqlSession.selectOne("member.checkPassword", member);
    }
	
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember", member);
	}
	public String searchMemberId(String memberPhone, String memberEmail) {
		Map<String, String> params = new HashMap<>();
        params.put("memberPhone", memberPhone);
        params.put("memberEmail", memberEmail);
		return sqlSession.selectOne("member.searchMemberId", params);
	}
	public String searchMemberPw(String memberId, String memberEmail) {
		Map<String, String> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberEmail", memberEmail);
		return sqlSession.selectOne("member.searchMemberPw", params);
	}
	public int updateMemberPassword(String memberId, String hashedPassword) {
		Map<String, String> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("hashedPassword", hashedPassword);
		return sqlSession.update("member.updateMemberPw", params);
	}

}
