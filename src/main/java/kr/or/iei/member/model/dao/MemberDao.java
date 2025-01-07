package kr.or.iei.member.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.vo.Member;

@Repository("dao")
public class MemberDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	//로그인
	public Member memberLogin(Member member) {
		return sqlSession.selectOne("member.selectOneMember", member);
	}
	//회원가입 - 일반회원
	public int join(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}
	//회원가입 - 전문가
	public int joinExpert(Member member) {
		return sqlSession.insert("member.insertExpert", member);
	}
	//회원가입 - 일반회원 
	public int joinWholeMember(Member member) {
		return sqlSession.insert("member.insertWholeMember", member);
	}
	//회원가입 - 전문가 
	public int joinWholeExpert(Member member) {
		return sqlSession.insert("member.insertWholeExpert", member);
	}
	//아이디 중복체크
	public int idDuplChk(String memberId) {		
		return sqlSession.selectOne("member.idDuplChk", memberId);
	}
	//MemberNo 가져오기
	public String selectMemberNo() {
		return sqlSession.selectOne("member.selectMemberNo");
	}
	//닉네임 중복체크
	public int nickDuplChk(String memberNickname) {
		return sqlSession.selectOne("member.nickDuplChk", memberNickname);
	}
	//회원 탈퇴
	public int deleteMember(String memberNo) {
        return sqlSession.delete("member.deleteMember", memberNo);
    }
	//비밀번호 확인
	public int checkPassword(Member member) {
        return sqlSession.selectOne("member.checkPassword", member);
    }
	//회원정보 수정
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember", member);
	}
	//아이디 찾기
	public String searchMemberId(String memberPhone, String memberEmail) {
		Map<String, String> params = new HashMap<>();
        params.put("memberPhone", memberPhone);
        params.put("memberEmail", memberEmail);
		return sqlSession.selectOne("member.searchMemberId", params);
	}
	//비밀번호 찾기
	public String searchMemberPw(String memberId, String memberEmail) {
		Map<String, String> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberEmail", memberEmail);
		return sqlSession.selectOne("member.searchMemberPw", params);
	}
	//비밀번호 찾기 - 임의의 숫자로 업데이트
	public int updateMemberPassword(String memberId, String hashedPassword) {
		Map<String, String> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("hashedPassword", hashedPassword);
		return sqlSession.update("member.updateMemberPw", params);
	}
	
	//profile_image 업데이트
	public boolean updateProfileImage(HashMap<String, String> parameterMap) {
		int result = sqlSession.update("member.updateProfileImage", parameterMap);
	    return result > 0;
    }
	// profile_image 없을 경우 새로 추가 (INSERT)
	public boolean insertProfileImage(HashMap<String, String> parameterMap) {
	    int result = sqlSession.insert("member.insertProfileImage", parameterMap);
	    return result > 0;
	}
}
