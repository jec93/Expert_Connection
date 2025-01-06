package kr.or.iei.category.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.or.iei.category.model.service.CategoryService;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.member.model.vo.Expert;
import kr.or.iei.member.model.vo.Member;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/categories")
@SessionAttributes("categories")
public class CategoryController {

	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	@Qualifier("categoryService")
	CategoryService categoryService;

    // 초기화 시 대분류 데이터 캐싱
    @GetMapping("/categoryFrm.exco")
    public String initializeCategories(Model model) {
    	// 애플리케이션 범위에서 데이터를 가져옴
        Map<String, Object> categories = (Map<String, Object>) servletContext.getAttribute("categories");

        // 데이터를 모델에 추가하여 JSP에 전달
        model.addAttribute("categories", categories);
        return "categories/categorySelect";
    }
    
    @GetMapping("/categoriesResult.exco")
    public String resultCategory(String thirdCode, String secondCode, String thirdName, Model model) {
    	model.addAttribute("thirdCode", thirdCode);
	    model.addAttribute("thirdName", thirdName);
	    model.addAttribute("secondCode", secondCode);
    	
	    //해당 소분류 코드를 가진 전문가 검색
	    ArrayList<ExpertIntroduce> expertList = categoryService.viewExpertListByThirdCd(thirdCode);
	    model.addAttribute("expertList",expertList);
	    
    	return "categories/categoryResult";
    }
    
    //카테고리를 선택(클릭)하고 넘어온 전문가 출력페이지에서 다른 소분류를 누를때 새로운 결과창
    @GetMapping(value = "/changeThirdCategories", produces = "application/json; charset=utf-8")
    @ResponseBody
    public ArrayList<ExpertIntroduce> changeThirdCategories(String thirdCode, String thirdName, String secondCode, Model model) {
    	ArrayList<ExpertIntroduce> response = categoryService.viewExpertListByThirdCd(thirdCode);
    	model.addAttribute("expertList",response);
    	return response;
    }
    
    @GetMapping("/searchThirdNm.exco")
    public String searchThirdNm(String keyword, Model model) {
    	ArrayList<ExpertIntroduce> srchList = categoryService.searchExperts(keyword);
    	if(srchList==null) {
    		model.addAttribute("title", "정보");
    		model.addAttribute("msg", "검색 결과 없음.");
    		model.addAttribute("icon", "info");
    		model.addAttribute("loc", "/categories/categoryFrm.exco");
    		return "common/msg";
    	}
    	model.addAttribute("keyword",keyword);
    	model.addAttribute("srchList",srchList);
    	return"/categories/srchResult";
    }
    
    @GetMapping("/searchSubCategoriesList.exco")
    public String searchSubCategoriesList(@RequestParam("thirdCategoryCDList") List<String> thirdCategoryCDList, String firstCategoryNm, Model model) {
    	ArrayList<ExpertIntroduce> srchList = categoryService.searchExpertsByThirdCdList(thirdCategoryCDList);
    	if(srchList==null) {
    		model.addAttribute("title", "정보");
    		model.addAttribute("msg", "검색 결과 없음.");
    		model.addAttribute("icon", "info");
    		model.addAttribute("loc", "/categories/categoryFrm.exco");
    		return "common/msg";
    	}
    	model.addAttribute("keyword",firstCategoryNm);
    	model.addAttribute("srchList",srchList);
    	return"/categories/srchResult";
    }
    
    //임시 로그인 학원컴터기준 admin 정보
    @GetMapping("/autoLogin.exco")
    public String autoLogin(HttpSession session) {
    	Member loginMember = new Member();
    	loginMember.setMemberNo("1");
    	loginMember.setMemberId("admin");
    	loginMember.setMemberPw("1234");
    	loginMember.setMemberNickname("관리자");
    	loginMember.setMemberPhone("010-1234-1234");
    	loginMember.setMemberAddr("대한민국");
    	loginMember.setMemberGender("0");
    	loginMember.setMemberType("0");
    	loginMember.setMemberEmail("admin@kh.com");
    	loginMember.setEnrollDate("24/12/23");
    	session.setAttribute("loginMember", loginMember);
    	return"redirect:/";
    }
}
