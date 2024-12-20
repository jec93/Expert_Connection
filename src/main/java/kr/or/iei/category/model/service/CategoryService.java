package kr.or.iei.category.model.service;

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

	public List<Map<String, Object>> getFirstCategories() {
	    return categoryDAO.getFirstCategories();
	}

	public List<Map<String, Object>> getSubCategories(String firstCode) {
	    return categoryDAO.getSubCategories(firstCode);
	}

}
