package kr.or.iei.category.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.co.shineware.nlp.komoran.model.KomoranResult;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.or.iei.category.model.dao.CategoryDao;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.member.model.vo.Expert;

@Service("categoryService")
public class CategoryService {
	
	@Autowired
	@Qualifier("categoryDao")
	private CategoryDao categoryDao;
	
	private final Komoran komoran;
	
	public CategoryService(Komoran komoran) {
		this.komoran=komoran;
	}

	@Autowired
	
	/*
	public ArrayList<CategoryHobby> allCategories() {
		// TODO Auto-generated method stub
		return (ArrayList<CategoryHobby>)dao.allCategories();
	}
	*/

	public Map<String, Object> getAllCategories() {
        // 대분류 가져오기
        List<Map<String, Object>> firstCategories = categoryDao.getFirstCategories();

        // 중분류 및 소분류 가져오기
        List<Map<String, Object>> subCategories = categoryDao.getSubCategories();
        
        // 데이터를 Map으로 구성
        Map<String, Object> allCategories = new HashMap<>();
        allCategories.put("firstCategories", firstCategories);
        allCategories.put("subCategories", subCategories);
        
        return allCategories;
    }

	public ArrayList<ExpertIntroduce> viewExpertListByThirdCd(String thirdCode) {
		// TODO Auto-generated method stub
		return (ArrayList<ExpertIntroduce>)categoryDao.viewExpertListByThirdCd(thirdCode);
	}

	public ArrayList<ExpertIntroduce> searchExperts(String keyword) {
		// TODO Auto-generated method stub
		// Komoran을 이용하여 입력 텍스트 분석
		KomoranResult result = komoran.analyze(keyword);
		
		// 명사만 추출
        List<String> keywords = result.getNouns();
        for(String s: keywords) {
        	System.out.println(s);
        }
        List<String> thirdCdList = categoryDao.thirdCdListByThirdNmList(keywords);
        if(thirdCdList.isEmpty()) {
        	return null;
        }
        List<ExpertIntroduce> searchExperts = categoryDao.srchExpertsByKeyList(thirdCdList);
        
        return (ArrayList<ExpertIntroduce>)searchExperts;
	}

}
