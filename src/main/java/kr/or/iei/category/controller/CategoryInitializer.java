package kr.or.iei.category.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import kr.or.iei.category.model.service.CategoryService;

@Component
public class CategoryInitializer {
	@Autowired
    @Qualifier("categoryService")
    private CategoryService categoryService;
	
	@Autowired
	private ServletContext servletContext;
	
	@PostConstruct
    public void initializeCategories() {
        System.out.println("초기데이터 부름");

        // 데이터베이스에서 모든 카테고리 데이터를 가져옴
        Map<String, Object> categories = categoryService.getAllCategories();
        
        //카테고리 null 여부 전달
        boolean isNull = false;
        List<Object> firstCategories =(List<Object>)categories.get("firstCategories");
        List<Object> subCategories = (List<Object>)categories.get("subCategories");
        if(firstCategories.isEmpty() || subCategories.isEmpty()) {
        	isNull = true;
        }

        // 애플리케이션 범위에 저장
        servletContext.setAttribute("categories", categories);
        
        // 서비스에서 널체크 보내고 싶었는데 못하겠어서 컨트롤러에서 함 (null일 경우 "추천 점검중"으로 링크 막음)
        servletContext.setAttribute("isNull", isNull);

        System.out.println("application 스코프 저장");
    }
}
