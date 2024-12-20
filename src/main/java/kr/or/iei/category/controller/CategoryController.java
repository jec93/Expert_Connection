package kr.or.iei.category.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.category.model.service.CategoryService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    @Qualifier("categoryService")
    private CategoryService categoryService;

    private List<Map<String, Object>> firstCategoriesCache;
    private Map<String, List<Map<String, Object>>> subCategoriesCache = new HashMap<>();

    // 초기화 시 대분류 데이터 캐싱
    @PostConstruct
    public void initCache() {
        firstCategoriesCache = categoryService.getFirstCategories(); // 대분류 데이터를 DB에서 조회하여 캐싱
    }

    @GetMapping("/categoryFrm.exco")
    public String categoryFrm() {
    	return"categories/categorySelect";
    }
    
    // 대분류 데이터 반환 (캐시 사용)
    @ResponseBody
    @GetMapping("/firstCategory.exco")
    public ResponseEntity<List<Map<String, Object>>> getFirstCategories() {
    	System.out.println("대분류 캐시 사용");
        return ResponseEntity.ok(firstCategoriesCache); // 캐싱된 데이터 반환
    }

    // 중분류 및 소분류 데이터 반환 (캐시 사용)
    @ResponseBody
    @GetMapping("/sub/{firstCode}.exco")
    public ResponseEntity<List<Map<String, Object>>> getSubCategories(@PathVariable String firstCode) {
        // 캐시에서 데이터 확인
        if (!subCategoriesCache.containsKey(firstCode)) {
            // 캐시에 없으면 DB에서 가져와 저장
            List<Map<String, Object>> subCategories = categoryService.getSubCategories(firstCode);
            subCategoriesCache.put(firstCode, subCategories);
        }
        return ResponseEntity.ok(subCategoriesCache.get(firstCode)); // 캐싱된 데이터 반환
    }
    
    @GetMapping("/categoriesResult.exco")
    public String resultCategory(String cateKey) {
    	/*
    	 
    	 
    	 
    	 cateKey(=전문가를 검색할 소분류 카테고리 코드값)을 사용하여
    	 카테고리 결과창에 해당 소분류 전문가 출력 내용 작성 공간
    	 
    	 
    	 
    	 */
    	return "categories/categoryResult";
    }
}
