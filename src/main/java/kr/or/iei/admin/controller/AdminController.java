package kr.or.iei.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.admin.model.service.AdminService;

@Controller("adminController")
@RequestMapping("/admin/")
public class AdminController {

	@Autowired
	@Qualifier("adminService")
	private AdminService adminService;
	
	//관리자페이지 -> 신고항목 관리 페이지 이동
	@GetMapping("reportManageFrm.exco")
	public String reportManageFrm() {
		
		return "admin/reportManage";
	}
	
}
