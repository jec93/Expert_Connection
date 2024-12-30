package kr.or.iei.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.admin.model.service.AdminService;
import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.admin.model.vo.ReportPageData;
import kr.or.iei.board.model.vo.BoardType;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

@Controller("adminController")
@RequestMapping("/admin/")
public class AdminController {

	@Autowired
	@Qualifier("adminService")
	private AdminService adminService;

	// private MemberService memberService;

	// 관리자페이지 -> 신고항목 관리 페이지 이동
	@GetMapping("reportManageFrm.exco")
	public String reportManageFrm() {

		return "admin/reportManage";
	}

	// 관리자페이지 -> 회원관리 - 신고내역관리 페이지 이동 + 신고내역 불러오기

	@GetMapping("memberManage.exco")
	public String memberManage(Integer reqPage, String searchName, Model model) {

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

		System.out.println(pd.getList());

		return "admin/memberManage";
	}

	// 게시글,댓글 신고하기
	@GetMapping("reportBoard.exco")
	public String insertReportByInfo(String targetNo, String boardType, String reporter, String reportType,
			String reportReason) {
		Report reportData = new Report();
		reportData.setTargetNo(targetNo);
		reportData.setReporter(reporter);
		reportData.setReportType(Integer.parseInt(reportType));
		reportData.setThirdCategoryCd(reportReason);
		adminService.insertReportByInfo(reportData);
		return "redirect:/board/list.exco?reqPage=1&boardType=" + boardType + "&boardTypeNm=" + boardType;
	}
}
