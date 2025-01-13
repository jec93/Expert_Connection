package kr.or.iei.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.iei.admin.model.vo.AccessRestriction;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.expert.model.vo.Review;
import kr.or.iei.member.model.service.EmailService;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Expert;
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
	public ModelAndView memberLogin(Member member, AccessRestriction accessRestriction, HttpSession session) {
	    // 전문가 로그인 시도
	    Member expertMember = memberService.expertLogin(member);
	    
	    // expertMember가 null이 아닐 경우 permissionState 값 출력
	    if (expertMember != null) {
	        
	        // 전문가 로그인 성공 후 상태 확인
	        if ("P".equals(expertMember.getPermissionState())) {
	            // 승인된 전문가 로그인 처리
	            session.setAttribute("loginMember", expertMember); // 로그인 정보 저장	 
	            return new ModelAndView("redirect:/"); // 전문가 대시보드로 리디렉션
	        } else {
	            // 승인되지 않은 전문가 처리
	            ModelAndView mav = new ModelAndView("member/expertWaiting"); // 승인 대기 페이지로 리디렉션
	            mav.addObject("loginFailMessage", "승인되지 않은 계정입니다. 관리자의 승인을 기다려주세요.");
	            return mav;
	        }
	        
	    }else {
	    	
	    	// 전문가 로그인 실패 시, 일반 회원 로그인 시도
	    	Member loginMember = memberService.memberLogin(member);
	    	
	    	if (loginMember != null) {
	    		
	    		// 제한 기간 내에 있을 경우 로그인 불가능
	    		if (loginMember.getLoginChkYn().equals("Y")) {
	    			ModelAndView mav = new ModelAndView("member/login");
	    			mav.addObject("loginFailMessage", "신고로 인한 제재기간입니다.");
	    			return mav;
	    		}
	    		
	    		// 정상 로그인 처리
	    		session.setAttribute("loginMember", loginMember);
	    		return new ModelAndView("redirect:/"); // 메인 페이지로 리디렉션
	    	} else {
	    		// 로그인 실패 시
	    		ModelAndView mav = new ModelAndView("member/login");
	    		mav.addObject("loginFailMessage", "로그인에 실패했습니다. 아이디와 비밀번호를 확인하세요.");
	    		return mav;
	    	}
	    }
	    
	}
	
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
	//회원가입 선택페이지로 이동
	@GetMapping("joinSelectFrm.exco")
	public String joinSelectFrm() {
		return "member/joinSelect";
	}
	//일반회원 가입 페이지로 이동
	@GetMapping("joinFrm.exco")
	public String joinFrm() {
		return "member/join";
	}
	//전문가회원 가입 페이지로 이동
	@GetMapping("joinExpertFrm.exco")
	public String joinExpertFrm() {
		return "member/joinExpert";
	}
	//이메일 인증
	@GetMapping("mailCheck.exco")
	@ResponseBody
	public String mailCheck(String email) {
		return emailService.joinEmail(email);
	}
	
	//회원가입 - 일반회원
	@PostMapping("join.exco")
	public String join(Member member) {
	    ArrayList<Member> memberList = new ArrayList<Member>();

	    int result = memberService.join(member, memberList);

	    if (result > 0) {
	        return "member/login";
	    } else {
	        return "member/join"; // join.jsp로 이동
	    }
	}
	//회원가입 - 전문가
	@PostMapping("joinExpert.exco")
	public String joinExpert(Member member, @RequestParam("portfolio") MultipartFile portfolio, HttpServletRequest request,
											@RequestParam("thirdCategoryCd") String thirdCategoryCd) {
	    // 파일이 없으면 오류 처리
	    if (portfolio.isEmpty()) {
	        return "member/join"; // 파일 없으면 다시 join 폼으로 돌아감
	    }

	    try {
	        // 파일 업로드 디렉토리 경로 설정
	        String uploadDir = request.getSession().getServletContext().getRealPath("/resources/portfolio/");
	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs(); // 디렉토리가 없으면 생성
	        }

	        // 파일 이름 설정
	        String fileName = portfolio.getOriginalFilename();
	        File saveFile = new File(dir, fileName);
	        portfolio.transferTo(saveFile); // 파일 저장

	        // 파일 경로 저장
	        String filePath = "/resources/portfolio/" + fileName;

	        // tbl_exco에 회원 기본 정보 저장
	        int result = memberService.joinExpert(member);

	        if (result > 0) {
	            // 회원가입이 성공하면, tbl_expert_management에 파일 경로 저장
	            memberService.saveExpertFile(member.getMemberNo(), filePath, fileName, thirdCategoryCd);
	            return "member/expertWaiting"; // 로그인 페이지로 리디렉션
	        } else {
	            return "member/join"; // 회원가입 실패 시 join 폼으로 돌아감
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        return "member/join"; // 오류 발생 시 join 폼으로 돌아감
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
	 public String mypageFrm(Model model, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberNo = loginMember.getMemberNo();
      
        // memberNo를 통해 데이터베이스에서 introduceContent를 가져오는 서비스 호출
        String introduceContent = memberService.getIntroduceContent(memberNo);
        
        // 모델에 introduceContent를 추가
        model.addAttribute("introduceContent", introduceContent);

        // 뷰 반환 (mypage.jsp)
        return "member/mypage";
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
			
		    return "member/mypage";
		}else {;
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
                               HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        // 로그인된 회원의 비밀번호 확인
        if (loginMember != null && loginMember.getMemberPw().equals(memberPw)) {
            int result = memberService.deleteMember(memberNo);

            if (result > 0) {
                session.invalidate();
                return "redirect:/"; 
            } else {
                return "member/deleteFail";
            }
        } else {
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
	        String profilePath = "/resources/profile/";
	        model.addAttribute("profilePath", profilePath);
	    }
	    
	    return "member/profile";
	}
	
	//프로필사진 업데이트
	@PostMapping("profileUpdateAjax.exco")
	public String uploadProfileImageAjax(
	        @RequestParam(value = "file", required = false) MultipartFile file,
	        @RequestParam(value = "memberNo", required = true) String memberNo,
	        HttpServletRequest request,
	        HttpSession session,
	        Model model) { // 세션을 주입받음


	    model.addAttribute("title", "알림");
	    // memberNo 확인
	    if (memberNo == null || memberNo.isEmpty()) {
	        model.addAttribute("msg", "memberNo가 전달되지 않았습니다.");
	        model.addAttribute("icon", "error");
	    }

	    // file 확인
	    if (file == null || file.isEmpty()) {
	    	model.addAttribute("msg", "파일이 업로드되지 않았습니다.");
	        model.addAttribute("icon", "error");
	    }

	    // 업로드 디렉토리 설정
	    String uploadDir = request.getSession().getServletContext().getRealPath("/resources/profile/");
	    File dir = new File(uploadDir);
	    if (!dir.exists() && !dir.mkdirs()) {
	    	model.addAttribute("msg", "디렉토리 생성 실패");
	        model.addAttribute("icon", "error");
	    }

	    try {
	        String profileName = file.getOriginalFilename();
	        File saveFile = new File(dir, profileName);
	        file.transferTo(saveFile);

	        // 프로필 사진 경로를 데이터베이스에 업데이트
	        String profilePath = "/resources/profile/";
	        boolean isUpdated = memberService.updateProfileImage(memberNo, profilePath, profileName);

	        if (isUpdated) {
	            // 세션에 새로운 프로필 정보를 갱신
	            Member updatedMember = memberService.getMemberById(memberNo);
	            session.setAttribute("loginMember", updatedMember); // 세션에 갱신된 member 객체 설정
	            
	            model.addAttribute("data", profilePath + profileName); //새 프로필 이미지 경로
	            model.addAttribute("msg", "프로필 이미지가 업데이트 되었습니다.");
		        model.addAttribute("icon", "success"); 
		        model.addAttribute("callback", "window.opener.profileUpd(\"" + profilePath + profileName + "\"); self.close();");
		        
	        } else {
	        	model.addAttribute("msg", "프로필 이미지가 업데이트 실패");
		        model.addAttribute("icon", "error");
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        model.addAttribute("msg", "파일 저장 중 오류 발생");
	        model.addAttribute("icon", "error");
	        
	    }
	    
	    return "common/msg";
	}


	
	//프로필사진 업데이트 팝업으로 이동
	@GetMapping("profileUpdateFrm.exco")
	public String profileUpdateFrm() {
		return "member/profileUpdateFrm";
	}
	
	@GetMapping("writtenBoardFrm.exco")
	public String writtenBoardFrm(HttpSession session, Model model, @RequestParam(value = "reqPage", defaultValue = "1") int reqPage) {
        // 세션에서 로그인된 사용자 정보 가져오기
        Member loginMember = (Member) session.getAttribute("loginMember");
       
        if (loginMember != null) {
            // 한 페이지에 표시할 게시글 수
            int boardsPerPage = 5;

            // 전체 게시글 가져오기
            List<Board> allBoards = memberService.getBoardsByMemberNo(loginMember.getMemberNo(),reqPage);

            // 시작과 끝 인덱스 계산
            int start = (reqPage - 1) * boardsPerPage;
            int end = Math.min(start + boardsPerPage, allBoards.size());

            // 해당 페이지에 표시할 게시글만 추출
            List<Board> paginatedBoards = allBoards.subList(start, end);

            // 각 게시글에 대한 댓글 및 댓글 수 조회
            Map<String, List<BoardComment>> commentsMap = new HashMap<>();
            Map<String, Integer> commentCountMap = new HashMap<>();
            for (Board board : paginatedBoards) {
                // 게시글에 대한 댓글 리스트 가져오기
                List<BoardComment> comments = memberService.getCommentsByBoardNo(board.getBoardNo(), loginMember.getMemberNo());
                commentsMap.put(board.getBoardNo(), comments);

                // 게시글에 대한 댓글 개수 가져오기
                int commentCount = memberService.getCommentCount(board.getBoardNo());
                commentCountMap.put(board.getBoardNo(), commentCount);
            }

            // JSP에서 사용할 데이터 추가
            model.addAttribute("boards", paginatedBoards); // 게시글 리스트
            model.addAttribute("commentsMap", commentsMap); // 댓글 리스트
            model.addAttribute("commentCountMap", commentCountMap); // 댓글 개수

            // 페이지네이션 정보 추가
            int totalBoards = allBoards.size(); // 전체 게시글 수
            model.addAttribute("totalBoards", totalBoards);
            model.addAttribute("reqPage", reqPage); // 현재 페이지 번호
            int totalPages = (int) Math.ceil((double) totalBoards / boardsPerPage); // 전체 페이지 수
            model.addAttribute("totalPages", totalPages);

        } else {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/login.exco";
        }

        return "member/writtenBoard"; // 게시글 확인 페이지 JSP 경로
    }
	

	//내가 작성한 댓글 페이지로 이동
	@GetMapping("writtenCommentFrm.exco")
	public String writtenCommentFrm(HttpSession session, Model model, @RequestParam(value = "reqPage", defaultValue = "1") int reqPage) {
	    // 세션에서 로그인된 사용자 정보 가져오기
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    if (loginMember != null) {
	        // 한 페이지에 표시할 댓글 수
	        int commentsPerPage = 5;

	        // 전체 댓글 가져오기
	        List<BoardComment> memberComments = memberService.getCommentsByMemberNo(loginMember.getMemberNo());

	        // 시작과 끝 인덱스 계산
	        int start = (reqPage - 1) * commentsPerPage;
	        int end = Math.min(start + commentsPerPage, memberComments.size());

	        // 해당 페이지에 표시할 댓글만 추출
	        List<BoardComment> paginatedComments = memberComments.subList(start, end);

	        // 전체 페이지 수 계산
	        int totalPages = (int) Math.ceil((double) memberComments.size() / commentsPerPage);

	        // 모델에 데이터 추가
	        model.addAttribute("comments", paginatedComments);
	        model.addAttribute("reqPage", reqPage);
	        model.addAttribute("totalPages", totalPages);

	    } else {
	        // 로그인되지 않은 경우 처리 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/login";
	    }

	    return "member/writtenComment"; // 게시글 확인 페이지 JSP 경로
	}
	//소개글 저장
	@PostMapping("saveIntroduce.exco")
    public String saveIntroduce(@RequestParam("introduceText") String introduceText, 
                                 @RequestParam("memberNo") String memberNo, RedirectAttributes redirectAttributes) {
        // 멤버의 소개글을 저장하고 결과 메시지를 반환
        boolean result = memberService.saveIntroduce(introduceText, memberNo);
        
        // 성공적으로 저장된 경우 리다이렉트
        if (result) {
        	redirectAttributes.addFlashAttribute("msg", "소개글이 저장되었습니다.");
            redirectAttributes.addFlashAttribute("icon", "success");
            return "redirect:/member/mypageFrm.exco";
        }
        
        // 실패한 경우 에러 페이지로 리턴
        return "errorPage1"; // 실패 시, 예시 에러 페이지
    }
	//전문가 마이페이지 포트폴리오 업로드
	@PostMapping("savePortfolio.exco")
	public String savePortfolio(@RequestParam("memberNo") String memberNo,
	                            @RequestParam("portfolioFiles") List<MultipartFile> portfolioFiles,
	                            HttpServletRequest request,
	                            Model model) {
	    model.addAttribute("title", "알림");

	    // 파일 저장 경로 설정
	    String uploadDir = request.getSession().getServletContext().getRealPath("/resources/portfolio/");
	    File dir = new File(uploadDir);
	    if (!dir.exists() && !dir.mkdirs()) {
	        model.addAttribute("msg", "디렉토리 생성 실패");
	        model.addAttribute("icon", "error");
	        return "common/msg";
	    }

	    try {
	        // 파일 저장 및 경로, 이름 DB 저장
	        List<String> savedFiles = new ArrayList<>();
	        for (MultipartFile file : portfolioFiles) {
	            if (file.isEmpty()) {
	                continue; // 빈 파일은 건너뛰기
	            }

	            String originalFilename = file.getOriginalFilename();
	            File saveFile = new File(dir, originalFilename);
	            file.transferTo(saveFile);

	            // 파일 경로와 이름 저장
	            String filePath = "/resources/portfolio/";
	            savedFiles.add(originalFilename);

	            boolean isSaved = memberService.savePortfolioFile(memberNo, filePath, originalFilename);
	            if (!isSaved) {
	                model.addAttribute("msg", "파일 저장 중 오류 발생");
	                model.addAttribute("icon", "error");
	                return "common/msg";
	            }
	        }

	        if (!savedFiles.isEmpty()) {
	            model.addAttribute("msg", "포트폴리오가 성공적으로 업로드되었습니다.");
	            model.addAttribute("icon", "success");
	        } else {
	            model.addAttribute("msg", "업로드된 파일이 없습니다.");
	            model.addAttribute("icon", "error");
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        model.addAttribute("msg", "파일 저장 중 오류 발생");
	        model.addAttribute("icon", "error");
	    }

	    return "common/msg";
	}
	@GetMapping("expertWaitingFrm.exco")
	public String expertWaitingFrm() {
		return "member/expertWaiting";
	}
	
	 // 리뷰 목록을 가져오는 메서드
   /* @RequestMapping("writtenReviewFrm.exco")
    public String getReviewList(@RequestParam("memberNo") String memberNo, Model model, HttpSession session, @RequestParam(value = "reqPage", defaultValue = "1") int reqPage) {
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
	        // 한 페이지에 표시할 리뷰 수
	        int reviewPerPage = 5;

	        // 전체 리뷰 가져오기
	        List<Review> reviewList = memberService.getReadReviewList(loginMember.getMemberNo());

	        // 시작과 끝 인덱스 계산
	        int start = (reqPage - 1) * reviewPerPage;
	        int end = Math.min(start + reviewPerPage, reviewList.size());

	        // 해당 페이지에 표시할 리뷰만 추출
	        List<Review> paginatedReview = reviewList.subList(start, end);

	        // 전체 페이지 수 계산
	        int totalPages = (int) Math.ceil((double) reviewList.size() / reviewPerPage);

	        // 모델에 데이터 추가
	        model.addAttribute("reviews", paginatedReview);
	        model.addAttribute("reqPage", reqPage);
	        model.addAttribute("totalPages", totalPages);

	    } else {
	        // 로그인되지 않은 경우 처리 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/login";
	    }
        
        return "member/writtenReview"; 
    }*/
}
	

