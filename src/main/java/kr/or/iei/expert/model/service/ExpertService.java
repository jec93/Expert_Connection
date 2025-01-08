package kr.or.iei.expert.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.expert.model.dao.ExpertDao;
import kr.or.iei.expert.model.vo.ExpertIntroduce;

@Service("expertService")
public class ExpertService {

	@Autowired
	private ExpertDao expertDao;

	public ExpertIntroduce viewExpertInfoByMemberNo(String memberNo) {
		return expertDao.viewExpertInfoByMemberNo(memberNo);
	}

	public List<ExpertIntroduce> findExpertsByCategory(String categoryNm, String addr) {
		return expertDao.findExpertsByCategory(categoryNm, addr);
	}

	public boolean updateExpertContent(String memberNo, String title, String content) {
		 int result = expertDao.updateExpertContent(memberNo, title, content);
	     return result > 0;
	}

	public boolean updatePortfolio(ExpertIntroduce portfolio) {
		int result = expertDao.updatePortfolio(portfolio);
	    return result > 0;
	}

}
