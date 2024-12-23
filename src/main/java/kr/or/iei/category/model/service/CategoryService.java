package kr.or.iei.category.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.category.model.dao.CategoryDao;

@Service("categoryService")
public class CategoryService {
	
	@Autowired
	@Qualifier("categoryDao")
	private CategoryDao categoryDAO;
	/*
	public ArrayList<CategoryHobby> allCategories() {
		// TODO Auto-generated method stub
		return (ArrayList<CategoryHobby>)dao.allCategories();
	}
	*/

	public Map<String, Object> getAllCategories() {
        // 대분류 가져오기
        List<Map<String, Object>> firstCategories = categoryDAO.getFirstCategories();

        // 중분류 및 소분류 가져오기
        List<Map<String, Object>> subCategories = categoryDAO.getSubCategories();
        
        // 데이터를 Map으로 구성
        Map<String, Object> allCategories = new HashMap<>();
        allCategories.put("firstCategories", firstCategories);
        allCategories.put("subCategories", subCategories);
        
        return allCategories;
    }

}
