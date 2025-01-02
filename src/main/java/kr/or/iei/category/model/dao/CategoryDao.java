package kr.or.iei.category.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.member.model.vo.Expert;

@Repository("categoryDao")
public class CategoryDao {
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

	public List<ExpertIntroduce> viewExpertListByThirdCd(String thirdCode) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("expertManagement.viewExpertListByThirdCd",thirdCode);
	}
	
	
}
