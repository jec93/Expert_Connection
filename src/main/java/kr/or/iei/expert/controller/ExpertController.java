package kr.or.iei.expert.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.expert.model.service.ExpertService;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.expert.model.vo.ExpertManagement;

@Controller("expertController")
@RequestMapping("/expert")
public class ExpertController {

	@Autowired
    private ExpertService expertService;

	// 전문가 리스트 조회(임시)
    @GetMapping("/expertList.exco")
    public String getExpertList(Model model) {
        ArrayList<ExpertManagement> expertList = expertService.getExpertList();
        
        model.addAttribute("expertList", expertList);
        return "member/expertList";
    }
    
	// 전문가 상세페이지로 이동 + 정보 가져오기
	@GetMapping("expertDetail.exco")
	public String expertDetail(String receiveNo, Model model) {
		
		ExpertManagement expertDetail = expertService.getExpertDetail(receiveNo);
		model.addAttribute("expertDetail", expertDetail);
		return "member/expertDetail";
	}
	
	//회원 번호로 전문가 소개 페이지 불러오기
	@GetMapping("/viewExpertInfoByMemberNo.exco")
	public String viewExpertInfoByMemberNo(String memberNo, Model model ) {
		ExpertIntroduce expertDetail = expertService.viewExpertInfoByMemberNo(memberNo);
		model.addAttribute("expertDetail",expertDetail);
		return "member/expertDetail";
	}
}
