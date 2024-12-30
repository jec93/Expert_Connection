package kr.or.iei.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.chat.model.service.AutoResService;

@Controller
@RequestMapping("/autoRes")
public class AutoResController {
	
	@Autowired
	@Qualifier("autoResService")
	private AutoResService autoResService;
	
	@GetMapping("/autoResFrm.exco")
	public String autoResFrm() {
		return "chat/setAutoRes";
	}

}
