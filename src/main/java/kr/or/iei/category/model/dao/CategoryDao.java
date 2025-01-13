package kr.or.iei.category.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.category.model.vo.Category;
import kr.or.iei.category.model.vo.RankKeywords;
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

	public List<ExpertIntroduce> viewAllExpertList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("expertManagement.viewAllExpertList");
	}

	public List<ExpertIntroduce> srchExpertsByKeyList(List<String> keywords) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("expertManagement.srchExpertsByKeyList",keywords);
	}

	public List<String> thirdCdListByThirdNmList(List<String> keywords) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.thirdCdListByThirdNmList",keywords);
	}
	
	public void updateCategoriesCntByCdList(List<String> thirdCdList) {
		// TODO Auto-generated method stub
		sqlSession.update("category.updateCategoriesCntByCdList",thirdCdList);
	}

	public List<RankKeywords> viewRankKeywords() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.viewRankKeywords");
	}

	public List<ExpertIntroduce> viewBestExpertList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("expertManagement.viewBestExpertList");
	}

	public String matchSecondCodeByThirdCode(String thirdCode) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("category.matchSecondCodeByThirdCode",thirdCode);
	}

	public int updateCategoryBymdfInfo(HashMap<String, String> mdfDataMap) {
		// TODO Auto-generated method stub
		return sqlSession.update("category.updateCategoryBymdfInfo",mdfDataMap);
	}

	public int deleteCategory(String thirdCode) {
		// TODO Auto-generated method stub
		return sqlSession.delete("category.deleteCategory",thirdCode);
	}

	public void deleteExpertManageByThird(String thirdCode) {
		// TODO Auto-generated method stub
		sqlSession.delete("category.deleteExpertManageByThird",thirdCode);
	}

	public int insertCategory(HashMap<String, String> cateMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("category.insertCategory",cateMap);
	}

	public List<Category> viewFiSeCategory(String secondCd) {
		// TODO Auto-generated method stub
		System.out.println("secondCd : "+secondCd);
		return sqlSession.selectList("category.viewFiSeCategory",secondCd);
	}

	public List<Map<String, Object>> getReportCategories() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.getReportCategories");
	}

	public List<Map<String, Object>> getNoticeCategories() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.noticeCategories");
	}

	public List<Map<String, Object>> getAllFirstCategories() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.getAllFirstCategories");
	}
}
