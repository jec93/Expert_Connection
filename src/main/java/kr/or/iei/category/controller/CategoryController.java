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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.or.iei.category.model.service.CategoryService;
import kr.or.iei.member.model.vo.Member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/categories")
@SessionAttributes("categories")
public class CategoryController {

	@Autowired
    private ServletContext servletContext;

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
    public String resultCategory(String cateKey, String thirdName, String secondCode, Model model) {
    	
    	 
    	model.addAttribute("cateKey", cateKey);
	    model.addAttribute("thirdName", thirdName);
	    model.addAttribute("secondCode", secondCode);
    	 
    	 /*
    	cateKey(=전문가를 검색할 소분류 카테고리 코드값)을 사용하여
    	카테고리 결과창에 해당 소분류 전문가 출력 내용 작성 공간
    	 
    	 
    	 
    	 */
    	return "categories/categoryResult";
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
