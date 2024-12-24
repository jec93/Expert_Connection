package kr.or.iei.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.member.model.dao.MemberDao;
import kr.or.iei.member.model.vo.Member;

@Service("service")
public class MemberService {

	@Autowired                                 
	@Qualifier("dao")
	private MemberDao memberDao;
	
	//로그인
	public Member memberLogin(Member member) {
		return memberDao.memberLogin(member);
	}
    
	//회원가입
	@Transactional
	public int join(Member member, ArrayList<Member> memberList) {
		
		String memberNo = memberDao.selectMemberNo();
		member.setMemberNo(memberNo);
		
		int result = memberDao.joinWholeMember(member);
		
		 if (result > 0) {
		        result = memberDao.join(member);
		        if (result <= 0) {
		            throw new RuntimeException();
		        }

		        for (Member member1 : memberList) {
		            member1.setMemberNo(memberNo);
		            result = memberDao.join(member1);

		            if (result <= 0) {
		                throw new RuntimeException();
		            }
		        }
		 }
		return result;
	}
	
	//아이디 중복체크
	public int idDuplChk(String memberId) {
		return memberDao.idDuplChk(memberId);
	}
	
	//닉네임 중복체크
	public int nickDuplChk(String memberNickname) {
		return memberDao.nickDuplChk(memberNickname);
	}

	//회원 탈퇴
	public int deleteMember(String memberNo) {
		return memberDao.deleteMember(memberNo);
	}
	
	//비밀번호 확인(회원탈퇴시)
	public int checkPassword(Member loginMember) {
        return memberDao.checkPassword(loginMember);
    }
	
	//회원정보 수정
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

}
