package kr.or.iei.common.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.category.model.service.CategoryService;

@Controller
@RequestMapping("/common/")
public class IndexController {
	
	@Autowired
	@Qualifier("categoryService")
	private CategoryService categoryService;
    
	@GetMapping("indexData.exco")
	@ResponseBody
	public HashMap<String, Object> viewIndexData(Model modle) {
		HashMap<String, Object> data = categoryService.viewIndexData();
		return data;
	}
}
