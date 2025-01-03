package kr.or.iei.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.iei.member.model.service.EmailService;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/member/")
public class MemberController {

	@Autowired
	@Qualifier("service")
	private MemberService memberService;
	
	@Autowired
	private EmailService emailService;
	
	//로그인
	@PostMapping("login.exco")
	public String memberLogin(Member member, HttpSession session) {
		Member loginMember = memberService.memberLogin(member);

		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		}else {
			return "member/loginFail";
		}

	}
	//카카오 로그인	
	
	
	//로그아웃
	@GetMapping("logout.exco")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	//로그인 페이지로 이동
	@GetMapping("loginFrm.exco")
	public String loginFrm() {
		return "member/login";
	}
	//회원가입 페이지로 이동
	@GetMapping("joinFrm.exco")
	public String joinFrm() {
		return "member/join";
	}
	//이메일 인증
	@GetMapping("mailCheck.exco")
	@ResponseBody
	public String mailCheck(String email) {
		return emailService.joinEmail(email);
	}
	
	//회원가입
	@PostMapping("join.exco")
	public String join(Member member) {
		ArrayList<Member> memberList = new ArrayList<Member>();
		
		int result = memberService.join(member, memberList);
		
		if(result > 0) {
			return "redirect:/";
		}else {
			return "member/joinFail";
		}
	}
	//아이디 중복체크
	@GetMapping("idDuplChk.exco")
	@ResponseBody
	public String idDuplChk(String memberId) {
		
		int cnt = memberService.idDuplChk(memberId);
		
		return String.valueOf(cnt);				
	}
	
	//닉네임 중복체크
	@GetMapping("nickDuplChk.exco")
	@ResponseBody
	public String nickDuplChk(String memberNickname) {
		
		int cnt = memberService.nickDuplChk(memberNickname);
		
		return String.valueOf(cnt);
	}
	//마이페이지로 이동
	@GetMapping("mypageFrm.exco")
	public String mypageFrm() {
		return "member/mypage_p";
	}
	//회원정보수정 페이지로 이동
	@GetMapping("updateFrm.exco")
	public String updateFrm() {
		return "member/update";
	}
	
	//회원정보 수정
	@PostMapping("update.exco")
	public String update(Member member, HttpSession session) {		
		Member loginMember = (Member) session.getAttribute("loginMember");
		member.setMemberId(loginMember.getMemberId());
		int result = memberService.updateMember(member);
		
		if(result > 0) {
			loginMember.setMemberPw(member.getMemberPw());
			loginMember.setMemberNickname(member.getMemberNickname());
			loginMember.setMemberPhone(member.getMemberPhone());
			loginMember.setMemberAddr(member.getMemberAddr());
			loginMember.setMemberGender(member.getMemberGender());
			loginMember.setMemberEmail(member.getMemberEmail());
			
			session.setAttribute("loginMember", loginMember);
			
			return "redirect:/";
		}else {
			return "member/updateFail";
		}
	}
	//회원탈퇴 페이지로 이동
	@GetMapping("deleteFrm.exco")
	public String deleteFrm() {
		return "member/delete";
	}
	
	//회원 탈퇴
    @PostMapping("delete.exco")
    public String deleteMember(@RequestParam("memberNo") String memberNo, 
                               @RequestParam("memberPw") String memberPw, 
                               HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        // 로그인된 회원의 비밀번호 확인
        if (loginMember != null && loginMember.getMemberPw().equals(memberPw)) {
            int result = memberService.deleteMember(memberNo);

            if (result > 0) {
                session.invalidate();
                return "redirect:/"; 
            } else {
                model.addAttribute("message", "회원 탈퇴에 실패했습니다.");
                return "member/deleteFail";
            }
        } else {
            model.addAttribute("message", "비밀번호가 맞지 않습니다.");
            return "member/deleteFail";
        }
    }
    //비밀번호 확인 후 탈퇴여부 확인
    @PostMapping("deleteCheck.exco")
    @ResponseBody
    public int deleteCheck(@RequestParam("memberPw") String memberPw, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember != null) {
            loginMember.setMemberPw(memberPw);
            // 비밀번호가 맞는지 확인
            int result = memberService.checkPassword(loginMember);
            return result; // 1이면 비밀번호 맞음, 0이면 비밀번호 틀림
        }

        return 0; // 로그인 상태가 아니면 0 반환
    }


	//아이디 찾기 페이지 이동
	@GetMapping("searchIdFrm.exco")
	public String searchIdFrm() {
		return "member/searchId";
	}
	
	//아이디 찾기
	@PostMapping("searchId.exco")
    @ResponseBody
    public String searchMemberId(@RequestParam("memberPhone") String memberPhone,
                                 @RequestParam("memberEmail") String memberEmail) {
        String memberId = memberService.searchMemberId(memberPhone, memberEmail);
        if (memberId != null) {
            return memberId;
        } else {
            return "일치하는 아이디를 찾을 수 없습니다";
        }
    }
	
	//비밀번호 찾기 페이지 이동
	@GetMapping("searchPwFrm.exco")
	public String searchPwFrm() {
		return "member/searchPw";
	}
	
	//비밀번호 찾기
	 @PostMapping("searchPw.exco")
	 @ResponseBody
	 public String searchMemberPw(@RequestParam("memberId") String memberId,
	                                 @RequestParam("memberEmail") String memberEmail) {
	     String memberPassword = memberService.searchMemberPassword(memberId, memberEmail);
	     
	        if (memberPassword != null) {
	            // 임시 비밀번호 생성
	            String temporaryPassword = memberService.generateTemporaryPassword();

	            // 임시 비밀번호를 업데이트
	            memberService.updateMemberPassword(memberId, temporaryPassword);

	            // 이메일로 임시 비밀번호 전송
	            emailService.sendTemporaryPassword(memberEmail, temporaryPassword);

	            return "<script>alert('임시 비밀번호를 이메일로 전송했습니다.'); location.href='/member/login.exco';</script>";
	        } else {
	            return "<script>alert('일치하는 정보를 찾을 수 없습니다.'); location.href='/member/searchPwFrm.exco';</script>";
	        }
	    }
	 
	//프로필사진
	@GetMapping("profileImage.exco")
	public String showProfilePage(HttpServletRequest request, Model model) {
	    Member loginMember = (Member) request.getSession().getAttribute("loginMember");
	    
	    // 프로필 사진 경로 설정
	    if (loginMember != null) {
	        String profileImagePath = "/resources/images/profile/" + loginMember.getProfileImage();
	        model.addAttribute("profileImagePath", profileImagePath);
	    }
	    
	    return "member/profile";
	}
	
	//프로필사진 업데이트
	@PostMapping("profileUpdateFrm.exco")
	public String uploadProfileImage(@RequestParam("file") MultipartFile file) {
	    String uploadDir = "/resources/profile";
	    File dir = new File(uploadDir);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    try {
	        File saveFile = new File(dir, file.getOriginalFilename());
	        file.transferTo(saveFile);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return "redirect:/profile";
	}

}
	

