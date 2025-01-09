package kr.or.iei.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.board.model.service.BoardService;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.member.model.dao.MemberDao;
import kr.or.iei.member.model.vo.Member;

@Service("service")
@Transactional
public class MemberService {

	@Autowired                                 
	@Qualifier("dao")
	private MemberDao memberDao;
	
	@Autowired                                
	private BoardService boardService;
	//로그인
	public Member memberLogin(Member member) {
		return memberDao.memberLogin(member);
	}
    
	//회원가입 - 일반회원
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
	
	//회원가입 - 전문가
	@Transactional
	public int joinExpert(Member member) {
		
		String memberNo = memberDao.selectMemberNo();
		member.setMemberNo(memberNo);
		
		int result = memberDao.joinWholeExpert(member);
		
		 if (result > 0) {
		        result = memberDao.join(member);
		        if (result <= 0) {
		            throw new RuntimeException();	       
		        }
		 }
		return result;
	}
	//회원가입 - 전문가 파일
	public void saveExpertFile(String memberNo, String filePath) {
		memberDao.insertExpertFile(memberNo, filePath);
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
	//프로필사진업데이트
	public Member getMemberById(Long memberNo) {
        // memberNo로 회원 정보를 조회하는 로직
        return memberDao.getMemberById(memberNo);
    }
	//아이디 찾기
	public String searchMemberId(String memberPhone, String memberEmail) {
		return memberDao.searchMemberId(memberPhone, memberEmail);
	}
	
	// 비밀번호 찾기
    public String searchMemberPassword(String memberId, String email) {
        return memberDao.searchMemberPw(memberId, email);
    }

    // 임시 비밀번호 생성
    public String generateTemporaryPassword() {
        int length = 10;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        StringBuilder temporaryPassword = new StringBuilder();

        Random random = new Random();
        for (int i = 0; i < length; i++) {
            temporaryPassword.append(characters.charAt(random.nextInt(characters.length())));
        }
        return temporaryPassword.toString();
    }

    // 비밀번호 업데이트
    public void updateMemberPassword(String memberId, String temporaryPassword) {
        String hashedPassword = temporaryPassword;
        memberDao.updateMemberPassword(memberId, hashedPassword);
    }
    
    //프로필사진 업데이트
	public boolean updateProfileImage(String memberNo, String profilePath,String profileName) {
		HashMap<String, String> parameterMap = new HashMap<String, String>();
		parameterMap.put("memberNo", memberNo);
		parameterMap.put("profilePath", profilePath);
		parameterMap.put("profileName", profileName);
		
		//해당 memberNo에 데이터가 있는지 확인
		boolean isUpdated = memberDao.updateProfileImage(parameterMap);

	    // 데이터가 없다면 INSERT 쿼리 실행
	    if (!isUpdated) {
	        return memberDao.insertProfileImage(parameterMap);
	    }
		return memberDao.updateProfileImage(parameterMap);
	}
	
	//게시글 가져오기
	public List<Board> getBoardsByMemberNo(String memberNo, int reqPage) {
        return boardService.getBoardsByMemberNo(memberNo, reqPage);
    }

    // 게시글에 대한 댓글 가져오기
    public List<BoardComment> getCommentsByBoardNo(String boardNo) {
        return boardService.getCommentsByBoardNo(boardNo);
    }

    // 전체 게시글 수 가져오기
    public int getTotalBoardsByMemberNo(String memberNo) {
        return boardService.getTotalBoardsByMemberNo(memberNo);
    }

	public int getCommentCount(String boardNo) {
		return boardService.getCommentCount(boardNo);
	}
	

}