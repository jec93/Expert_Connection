package kr.or.iei.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.chat.model.service.AutoResService;
import kr.or.iei.chat.model.vo.AutoRes;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/autoRes")
public class AutoResController {
	
	@Autowired
	@Qualifier("autoResService")
	private AutoResService autoResService;
	
	@GetMapping("/autoResFrm.exco")
	public String autoResFrm(Model model, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		if (loginMember == null) {
	        return "redirect:/login";
	    }
		
		String memberNo = loginMember.getMemberNo();
		String isActive = autoResService.getAutoResState(memberNo); // 자동응답 on/off 상태 조회
		
		ArrayList<AutoRes> autoResList = autoResService.getResponseList(memberNo);
		model.addAttribute("autoResList", autoResList);
		model.addAttribute("isActive", isActive);
		return "chat/setAutoRes";
	}

	// 새로운 자동응답 삽입
	@PostMapping("/autoResSave.exco")
	@ResponseBody
	public Map<String, Object> saveResponse(String triggerWord, String responseContent, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    Member loginMember = (Member) session.getAttribute("loginMember");
	    if (loginMember == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }

	    // AutoRes 객체 생성 및 데이터 설정
	    AutoRes autoRes = new AutoRes();
	    autoRes.setTriggerWord(triggerWord);
	    autoRes.setResponseContent(responseContent);
	    autoRes.setMemberNo(loginMember.getMemberNo());

	    // 서비스 호출
	    boolean isSaved = autoResService.saveResponse(autoRes);
	    response.put("success", isSaved);

	    if (!isSaved) {
	        response.put("message", "데이터 저장에 실패했습니다.");
	    }
	    return response;
	}

	
	// 자동응답 on / off 업데이트
	@PostMapping("/autoResUpdateState.exco")
	@ResponseBody
	public Map<String, Object> updateAutoResState(String state, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }

	    String memberNo = loginMember.getMemberNo();

	    // state를 'Y' 또는 'N'으로 검증
	    if (!state.equals("Y") && !state.equals("N")) {
	        response.put("success", false);
	        response.put("message", "잘못된 상태 값입니다.");
	        return response;
	    }

	    // 데이터베이스 업데이트
	    boolean result = autoResService.updateAutoResState(memberNo, state);
	    response.put("success", result);
	    response.put("message", result ? "자동응답 상태가 성공적으로 업데이트되었습니다." : "자동응답 상태 업데이트에 실패했습니다.");

	    return response;
	}
	
	//질문 삭제
	@PostMapping("/autoResDelete.exco")
	@ResponseBody
	public Map<String, Object> deleteResponse(String responseNo, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    Member loginMember = (Member) session.getAttribute("loginMember");
	    if (loginMember == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }

	    boolean isDeleted = autoResService.deleteResponse(responseNo);

	    response.put("success", isDeleted);
	    if (!isDeleted) {
	        response.put("message", "질문 삭제에 실패했습니다.");
	    }

	    return response;
	}
}
