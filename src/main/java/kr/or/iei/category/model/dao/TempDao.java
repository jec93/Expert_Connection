package kr.or.iei.category.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("categoryDao")
public class TempDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
/*
	public List<CategoryHobby> allCategories() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.allCategory");
	}
	*/

	public List<Map<String, Object>> getFirstCategories() {
	    return sqlSession.selectList("category.getFirstCategories");
	}

	public List<Map<String, Object>> getSubCategories() {
	    return sqlSession.selectList("category.getAllSubCategories");
	}
	
	
}
