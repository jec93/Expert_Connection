package kr.or.iei.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.member.model.dao.MemberDao;
import kr.or.iei.member.model.vo.Expert;
import kr.or.iei.member.model.vo.Member;

@Service("service")
public class MemberService {

	@Autowired                                 
	@Qualifier("dao")
	private MemberDao memberDao;
	
	 public Object memberLogin(Member member) {
	        // 1. 일반 회원 로그인 처리
	        Member loginMember = memberDao.memberLogin(member);

	        // 2. 일반 회원 로그인 실패 시 전문가 로그인 시도
	        if (loginMember == null) {
	            // Member 로그인 실패 시 Expert 로그인 처리
	            Expert expert = new Expert();
	            expert.setExpertId(member.getMemberId());
	            expert.setExpertPw(member.getMemberPw());
	            Expert loginExpert = memberDao.expertLogin(expert);

	            // 로그인 성공한 Expert 객체 반환
	            if (loginExpert != null) {
	                return loginExpert;  // 전문가 로그인 성공
	            }
	            return null;  // 전문가 로그인 실패
	        }

	        return loginMember;  // 일반 회원 로그인 성공
	    }
    
	
	@Transactional
	public int join(Member member, ArrayList<Member> memberList) {
		
		String memberNo = memberDao.selectMemberNo();
		member.setMemberNo(memberNo);
		
		int result = memberDao.joinWholeMember(member);
		
		 if (result > 0) {
		        result = memberDao.join(member); // tbl_inexpert_site에 데이터 삽입
		        if (result <= 0) {
		            throw new RuntimeException("Failed to insert into tbl_inexpert_site");
		        }

		        for (Member member1 : memberList) {
		            member1.setMemberNo(memberNo);
		            result = memberDao.join(member1);  // 추가적인 데이터 삽입

		            if (result <= 0) {
		                throw new RuntimeException("Failed to insert additional members");
		            }
		        }
		 }
		return result;
	}
	
	public int idDuplChk(String memberId) {
		return memberDao.idDuplChk(memberId);
	}

	public int nickDuplChk(String memberNickname) {
		return memberDao.nickDuplChk(memberNickname);
	}

	public int deleteMember(String memberNo) {
		return memberDao.deleteMember(memberNo);
	}
	
	public int checkPassword(Member loginMember) {
        return memberDao.checkPassword(loginMember);
    }

	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

}
