package kr.or.iei.category.controller;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import kr.or.iei.category.model.service.CategoryService;

@Component("categoryInitial")
public class CategoryInitializer {
	@Autowired
    @Qualifier("categoryService")
    private CategoryService categoryService;
	
	@Autowired
	private ServletContext servletContext;
	
	@PostConstruct
    public void initializeCategories() {
        System.out.println("초기데이터 부름");
        loadCategories();
    }
	
	public void refreshCategories() {
        System.out.println("데이터 새로고침 실행");
        loadCategories();
    }
	
	 private void loadCategories() {
        Map<String, Object> categories = categoryService.getAllCategories();
        
        //카테고리 null 여부 전달
        boolean isNull = false;
        List<Object> firstCategories = (List<Object>) categories.get("firstCategories");
        List<Object> subCategories = (List<Object>) categories.get("subCategories");
        if (firstCategories.isEmpty() || subCategories.isEmpty()) {
            isNull = true;
        }

        servletContext.setAttribute("categories", categories);
        servletContext.setAttribute("isNull", isNull);

        System.out.println("카테고리 데이터 저장 완료");
    }
}
