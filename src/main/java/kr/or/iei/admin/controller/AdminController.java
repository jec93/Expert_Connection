package kr.or.iei.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.admin.model.service.AdminService;
import kr.or.iei.admin.model.vo.AccessRestriction;
import kr.or.iei.admin.model.vo.ExpertPageData;
import kr.or.iei.admin.model.vo.MemberPageData;
import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.admin.model.vo.ReportPageData;
import kr.or.iei.board.model.service.BoardService;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardType;
import kr.or.iei.common.emitter.Emitter;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

@Controller("adminController")
@RequestMapping("/admin/")
public class AdminController {

	@Autowired
	@Qualifier("adminService")
	private AdminService adminService;
	
	@Autowired
	@Qualifier("boardService")
	private BoardService boardservice;
	
	@Autowired
	private Emitter emitter;

	// private MemberService memberService;

	// 관리자페이지 -> 신고항목 관리 페이지 이동
	@GetMapping("reportManageFrm.exco")
	public String reportManageFrm() {
		return "admin/reportManage";
	}

	// 관리자페이지 -> 회원관리 - 신고내역관리 페이지 이동 + 신고내역 불러오기
	@GetMapping("memberReportManage.exco")
	public String memberReportManage(Integer reqPage, String searchName, Model model) {

		ReportPageData pd = null;
		if (searchName.equals("report")) {
			pd = adminService.selectAllReportList(reqPage, searchName);
		} else if (searchName.equals("null")) {
			pd = adminService.selectAllReportList(reqPage, searchName);
		} else {
			pd = adminService.selectAllReportList(reqPage, searchName);
		}

		model.addAttribute("reportList", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());
		model.addAttribute("searchName", searchName);

		//System.out.println(pd.getList());

		return "admin/memberManage";
	}

	// 게시글,댓글 신고하기
	@GetMapping("reportBoard.exco")
	public String insertReportByInfo(String targetNo, String boardType, String reporter, String reportType, String reportCd, String reportNm, Model model) {
		Report reportData = new Report();
		String reportNo = adminService.createReportNo();
		reportData.setReportNo(reportNo);
		reportData.setTargetNo(targetNo);
		reportData.setReporter(reporter);
		reportData.setReportType(Integer.parseInt(reportType));
		reportData.setThirdCategoryCd(reportCd);
		reportData.setThirdCategoryNM(reportNm);
		adminService.insertReportByInfo(reportData);
		model.addAttribute("title","신고해주셔서 감사합니다.");
		model.addAttribute("msg", "사용자님의 신고로 Expert Connection의 규정을 어기고 이용환경을 해치는 사용자를 적발하는데 많은 도움이 되었습니다. 보내주신 신고내용은 검토 후 회신드리겠습니다. (허위신고 등은 신고자 본인에게 제재가 가해질 수 있습니다.) 앞으로도 규정을 어기는 사용자가 있다면 신고기능을 적극 이용해주시길 부탁드립니다. 감사합니다. 🍀");
		model.addAttribute("icon","info");
		model.addAttribute("loc","/board/list.exco?reqPage=1&boardType=" + boardType + "&boardTypeNm=" + boardType);
		
		String adminId = "admin"; // 관리자 ID 지정
	    String writer = null;
	    String notificationMessage = null;
	        
	    // reportType에 따라 작성자 정보를 조회
	    if ("0".equals(reportType)) {
	        Board boardInfo = boardservice.getBoardWithMemberInfo(targetNo); // 게시글 작성자 정보 조회
	        writer = boardInfo.getMemberNo();
	        notificationMessage = "귀하의 게시글이 신고되었습니다. 부당한 신고 혹은 이의신청 등은 관리자에게 문의 바랍니다.";
	    } else if ("1".equals(reportType)) {
	        Board commentInfo = boardservice.getCommentWriter(targetNo); // 댓글 작성자 정보 조회
	        writer = commentInfo.getMemberNo();
	        notificationMessage = "귀하의 댓글이 신고되었습니다. 부당한 신고 혹은 이의신청 등은 관리자에게 문의 바랍니다.";
	    }

	    // 관리자에게 알림 전송
	    String adminNotification = "새로운 신고가 접수되었습니다.";
	    String url = "/admin/memberReportManage.exco?reqPage=1&searchName=report";
	    emitter.sendEvent(adminId, adminNotification, url);
	    System.out.println("관리자 알림이 전송되었습니다.");
	    
	    // 게시글 또는 댓글 작성자에게 알림 전송
	    if (writer != null && !writer.equals(reporter)) {
	        // 1:1 문의 URL 생성
	        String writerUrl = "/board/writeFrm.exco?boardType=6&boardTypeNm=1:1문의";
	        emitter.sendEvent(writer, notificationMessage, writerUrl);
	        System.out.println("작성자 알림이 전송되었습니다.");
	    }

		return "common/msg";
	}
	
	//관리자페이지 -> 회원관리 - 회원정보 + 신고한 횟수, 신고받은 횟수, 접근제한 횟수 불러오기
	@GetMapping("memberManage.exco")
	public String memberManage(int reqPage, String searchName, Model model) {
		
		MemberPageData pd = null;
		if(searchName.equals("whole")) {
			pd = adminService.selectWholeMemberList(reqPage, searchName);
		} else if (searchName.equals("null")) {
			pd = adminService.selectWholeMemberList(reqPage, searchName);
		} else {
			pd = adminService.selectWholeMemberList(reqPage, searchName);
		}
		
		model.addAttribute("reportMemberList", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());
		model.addAttribute("searchName", searchName);
		
		return "admin/memberManage";
	}
	
	//관리자페이지 -> 신고대상 클릭시 해당 게시글로 이동
	@GetMapping("viewBoard.exco")
	public String viewBoard(String targetNo, String commentChk, Model model) {
		
		String boardNo = targetNo;
		
		//System.out.println(boardNo);
		
		Board board = adminService.viewBoard(boardNo, commentChk);
		
		if (board == null) {
			return "redirect:/admin/memberManage";
		}
		model.addAttribute("board", board);
		return "board/view";
	}
	
	//관리자페이지 -> 신고대상 클릭시 해당 댓글로 이동
	@GetMapping("viewComment.exco")
	public String viewComment(String targetNo, String commentChk, Model model) {
		
		String commentNo = targetNo;
		
		//댓글 번호로 댓글이 작성된 게시글 번호 조회
		String boardNo = adminService.searchBoardNoByCommentNo(commentNo);
		
		if (boardNo == null) {
			return "admin/memberManage";
		} else {
			Board board = adminService.viewBoard(boardNo, commentChk);
			
			if (board == null) {
				return "redirect:admin/memberManage";
			}
			model.addAttribute("board", board);
			return "board/view";
		}
	}
	
	//관리자페이지 -> 신고확인버튼 클릭시 팝업띄워주기
	@GetMapping("checkReport.exco")
	public String checkReport(String reportNo, Model model) {
		
		Report report = adminService.checkReport(reportNo);
		
		if(report == null) {
			return "admin/memberManage";
		}
		model.addAttribute("report", report);
		
		return "admin/checkReport";
	}
	
	//관리자페이지 -> 신고대상 클릭시 해당 게시글로 이동
	@GetMapping("checkBoard.exco")
	public String checkBoard(String targetNo, String commentChk, Model model) {
		
		String boardNo = targetNo;
		
		System.out.println(boardNo);
		
		Board board = adminService.viewBoard(boardNo, commentChk);
		
		if (board == null) {
			return "redirect:admin/memberManage";
		}
		model.addAttribute("board", board);
		return "admin/checkBoard";
	}
	
	//관리자페이지 -> 신고대상 클릭시 해당 댓글로 이동
	@GetMapping("checkComment.exco")
	public String checkComment(String targetNo, String commentChk, Model model) {
		
		String commentNo = targetNo;
		
		//댓글 번호로 댓글이 작성된 게시글 번호 조회
		String boardNo = adminService.searchBoardNoByCommentNo(commentNo);
		
		if (boardNo == null) {
			return "admin/memberManage";
		} else {
			Board board = adminService.viewBoard(boardNo, commentChk);
			
			if (board == null) {
				return "redirect:admin/memberManage";
			}
			model.addAttribute("board", board);
			return "admin/checkComment";
		}
	}
	
	//관리자페이지 - 신고확정 : 신고받은 회원 로그인제한+신고대상 삭제
	@GetMapping("trueReport.exco")
	public String trueReport(String reportNo, String suspect, int reportType, String targetNo, Model model) {
		
		//신고테이블에서 신고처리결과 D->Y로 변경
		int report = adminService.updateReportResultbyReportNo(reportNo);
		
		//System.out.println("report : " + report);
		
		//신고대상 삭제
		//신고대상이 게시글인 경우
		if (report > 0 && reportType == 0) {
			String boardNo = targetNo;
			int board = adminService.deleteBoardByBoardNo(boardNo);
			
		} else if (report > 0 && reportType == 1){	//신고대상이 댓글인경우
			String commentNo = targetNo;
			int comment = adminService.deleteBoardByBoardNo(commentNo);
		}
		
		//접근제한 테이블에 넣기 전, insert 대상 회원이 이미 정지 상태인지 체크
		String memberNo = suspect;
		
		int chkAccess = adminService.checkAccess(memberNo, reportNo);
		
		if(chkAccess == 0) {
			//접근제한 테이블에 넣어주기 7일
			int acres = adminService.firstAccessRestriction(reportNo, memberNo);
			
			if(acres > 0) {
				model.addAttribute("title","신고수리 완료");
				model.addAttribute("msg", "신고대상을 삭제하고, 신고대상을 작성한 사용자의 로그인을 7일간 제한합니다.");
				model.addAttribute("icon","success");
				model.addAttribute("loc","memberReportManage.exco?reqPage=1&searchName=report");
			}
		} else if (chkAccess == 1) {
			//접근제한 테이블에 넣어주기 15일
			int acres = adminService.secondAccessRestriction(reportNo, memberNo);
			
			if(acres > 0) {
				model.addAttribute("title","신고수리 완료");
				model.addAttribute("msg", "신고대상을 삭제하고, 신고대상을 작성한 사용자의 로그인을 15일 간 제한합니다.");
				model.addAttribute("icon","success");
				model.addAttribute("loc","memberReportManage.exco?reqPage=1&searchName=report");
			}
		} else if (chkAccess == 2) {
			//접근제한 테이블에 넣어주기 100년
			int acres = adminService.thirdAccessRestriction(reportNo, memberNo);
			
			if(acres > 0) {
				model.addAttribute("title","신고수리 완료");
				model.addAttribute("msg", "신고대상을 삭제하고, 신고대상을 작성한 사용자의 로그인을 영구제한합니다.");
				model.addAttribute("icon","success");
				model.addAttribute("loc","memberReportManage.exco?reqPage=1&searchName=report");
			}
		}
		model.addAttribute("isPopup",true);
		return "common/msg";
	}
	
	//관리자페이지 - 허위신고 : 신고한 회원 로그인제한
	@GetMapping("fakeReport.exco")
	public String fakeReport(String reportNo, String reporter, Model model) {
	
		//신고테이블에서 신고처리결과 D->N로 변경
		int report = adminService.updateReportResult(reportNo);
		//System.out.println("허위신고 report : " + report);
		
		if (report > 0) {
		//접근제한 테이블에 넣기 전, insert 대상 회원이 이미 정지 상태인지 체크
		String memberNo = reporter;
		
		int chkAccess = adminService.checkAccess(memberNo, reportNo);
		
		//System.out.println("허위신고 chkAccess : " + chkAccess);
		
		if(chkAccess == 0) {
			//접근제한 테이블에 넣어주기 7일
			int acres = adminService.firstAccessRestriction(reportNo, memberNo);
			
			if(acres > 0) {
				model.addAttribute("title","허위신고 처리 완료");
				model.addAttribute("msg", "허위신고자의 로그인을 7일간 제한합니다.");
				model.addAttribute("icon","success");
			}
		} else if (chkAccess == 1) {
			//접근제한 테이블에 넣어주기 15일
			int acres = adminService.secondAccessRestriction(reportNo, memberNo);
			
			if(acres > 0) {
				model.addAttribute("title","허위신고 처리 완료");
				model.addAttribute("msg", "신고대상을 삭제하고, 신고대상의 로그인을 15일 간 제한합니다.");
				model.addAttribute("icon","success");
			}
		} else if (chkAccess == 2) {
			//접근제한 테이블에 넣어주기 100년
			int acres = adminService.thirdAccessRestriction(reportNo, memberNo);
			
			if(acres > 0) {
				model.addAttribute("title","허위신고 처리 완료");
				model.addAttribute("msg", "신고대상을 삭제하고, 신고대상의 로그인을 영구제한합니다.");
				model.addAttribute("icon","success");
			}
		}
		
		}
		model.addAttribute("isPopup",true);
		return "common/msg";
	}
	
	//관리자페이지 -> 신고처리내역 목록 불러오기
	@GetMapping("reportResult.exco")
	public String reportResultManage(Integer reqPage, String searchName, Model model) {

		ReportPageData pd = null;
		if (searchName.equals("done")) {
			pd = adminService.selectAllReportResultList(reqPage, searchName);
		} else if (searchName.equals("null")) {
			pd = adminService.selectAllReportResultList(reqPage, searchName);
		} else {
			pd = adminService.selectAllReportResultList(reqPage, searchName);
		}

		model.addAttribute("reportList", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());
		model.addAttribute("searchName", searchName);

		System.out.println(pd.getList());

		return "admin/memberManage";
	}
	
	@GetMapping("updateCategoryBymdfInfo.exco")
	public String updateCategoryBymdfInfo(String key, String code, String mdfName, Model model) {
	    System.out.println("Key: " + key);
	    System.out.println("Code: " + code);
	    System.out.println("MdfName: " + mdfName);
	    
	    // 업데이트 수행
	    int result = adminService.updateCategoryBymdfInfo(key, code, mdfName);
	    
	    if(result>0) {
	    	model.addAttribute("icon","success");
		    model.addAttribute("title","카테고리 수정완료");
	    }else {
	    	model.addAttribute("icon","error");
		    model.addAttribute("title","카테고리 수정실패");
	    }
	    return "common/msg";
	}
	
	@GetMapping("deleteCategory.exco")
	public String deleteCategory(String thirdCode,Model model) {
		int result = adminService.deleteCategory(thirdCode);
		if(result>0) {
			model.addAttribute("icon","success");
			model.addAttribute("title","카테고리 삭제완료");
		}else {
			model.addAttribute("icon","error");
			model.addAttribute("title","카테고리 삭제실패");
		}
		return "common/msg";
	}
	
	@GetMapping("insertCategory.exco")
	public String insertCategory(String key, String firstCd,String secondCd, String categoryNm, Model model) {
		int result = adminService.insertCategory(key, firstCd, secondCd, categoryNm);
		if(result>0) {
			model.addAttribute("icon","success");
			model.addAttribute("title","카테고리 추가완료");
		}else {
			model.addAttribute("icon","error");
			model.addAttribute("title","카테고리 추가실패");
		}
		return "common/msg";
	}
	
	/*
	 * @GetMapping("deleteCategory.exco") public String
	 */
	
	//관리자 페이지 -> 전문가 승인 검토 + 활동중인 전문가 목록 페이지로 이동
	@GetMapping("expertManagement.exco")
	public String expertManagemnet(int reqPage, String searchName, Model model) {
		
		ExpertPageData pd = null;
		if(searchName.equals("expected")) {
			pd = adminService.selectExpectedExpertList(reqPage, searchName);
		} else if (searchName.equals("null")) {
			pd = adminService.selectExpectedExpertList(reqPage, searchName);
		} else if (searchName.equals("approval")) {
			pd = adminService.selectApprovalExpertList(reqPage, searchName);
		} else if (searchName.equals("decline")) {
			pd = adminService.selectDeclineExpertList(reqPage, searchName);
		} else if (searchName.equals("hold")) {
			pd = adminService.selectHoldExpertList(reqPage, searchName);
		}
		
		model.addAttribute("expertList", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());
		model.addAttribute("searchName", searchName);
		
		return "admin/expertManage";
	}
	
	//관리자 페이지 -> 전문가 승인 반려
	@GetMapping("expertDecline.exco")
	public String expertDecline(String receiveNo, Model model) {
		//System.out.println(receiveNo);
		
		int result = adminService.expertDecline(receiveNo);
		
		System.out.println("adminDao : " + result);
		if(result > 0) {
			model.addAttribute("icon","success");
			model.addAttribute("title","전문가 승인 반려 완료");
			model.addAttribute("text", "해당 승인 요청을 반려했습니다.");

		}else {
			model.addAttribute("icon","error");
			model.addAttribute("title","전문가 승인 반려 실패");
			model.addAttribute("text", "해당 승인 요청을 처리하는 중 오류가 발생했습니다.");
		}
		return "common/msg";
	}
	//관리자페이지 -> 전문가 승인 정지
	@GetMapping("expertHold.exco")
	public String expertHold(String receiveNo, Model model) {
		int result = adminService.expertHold(receiveNo);
		
		System.out.println("adminDao : " + result);
		if(result > 0) {
			model.addAttribute("icon","success");
			model.addAttribute("title","활동 정지");
			model.addAttribute("text", "해당 전문가의 활동을 정지시켰습니다.");

		}else {
			model.addAttribute("icon","error");
			model.addAttribute("title","활동 제한 실패");
			model.addAttribute("text", "해당 요청을 처리하는 중 오류가 발생했습니다.");
		}
		return "common/msg";
	}
	
	//관리자페이지 -> 전문가 승인 취소(활동 정지)
	@GetMapping("expertApproval.exco")
	public String expertApproval(String receiveNo, Model model) {
		int result = adminService.expertApproval(receiveNo);
		
		System.out.println("adminDao : " + result);
		if(result > 0) {
			model.addAttribute("icon","success");
			model.addAttribute("title","전문가 승인 완료");
			model.addAttribute("text", "해당 승인 요청을 완료했습니다.");

		}else {
			model.addAttribute("icon","error");
			model.addAttribute("title","전문가 승인 실패");
			model.addAttribute("text", "해당 승인 요청을 처리하는 중 오류가 발생했습니다.");
		}
		return "common/msg";
	}
	
	//관리자페이지 - 신고확정 : 신고받은 회원 로그인제한+신고대상 삭제
	@GetMapping("immediatelyReport.exco")
	public String immediatelyReport(String suspect,String boardNo, Model model) {
		Report reportData = new Report();
		String reportNo = adminService.createReportNo();
		System.out.println(reportNo);
		reportData.setReportNo(reportNo);
		reportData.setTargetNo(boardNo);
		reportData.setReporter("1");
		reportData.setReportType(0);
		reportData.setThirdCategoryCd("A_301_a0002");
		reportData.setThirdCategoryNM("영구 밴");
		adminService.insertReportByInfo(reportData);
		
		//신고테이블에서 신고처리결과 D->Y로 변경
		adminService.updateReportResultbyReportNo(reportNo);
		System.out.println(reportNo);
		
		//신고대상 삭제
		//게시글에만 적용했으므로 게시글No사용
		int board = adminService.deleteBoardByBoardNo(boardNo);
		//접근제한 테이블에 넣어주기 100년
		int acres = adminService.thirdAccessRestriction(reportNo, suspect);
		
		if(acres > 0) {
			model.addAttribute("title","신고수리 완료");
			model.addAttribute("msg", "신고대상을 삭제하고, 신고대상을 작성한 사용자의 로그인을 영구제한합니다.");
			model.addAttribute("icon","success");
		}else {
			model.addAttribute("title","신고수리 실패");
			model.addAttribute("msg", "처리중 오륲");
			model.addAttribute("icon","error");
		}
		
		return "common/msg";
	}
}
