package kr.or.iei.expert.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.expert.model.dao.ExpertDao;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.expert.model.vo.Review;

@Service("expertService")
public class ExpertService {

	@Autowired
	private ExpertDao expertDao;

	public ExpertIntroduce viewExpertInfoByMemberNo(String memberNo) {
		ExpertIntroduce expertIntroduce = expertDao.viewExpertInfoByMemberNo(memberNo);
		ArrayList<Review> reviewList = (ArrayList<Review>) expertDao.readReviewListByIntroNo(expertIntroduce.getIntroNo());
		expertIntroduce.setReviewList(reviewList);
		return expertIntroduce;
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

	public int insertReview(Review review) {
		// TODO Auto-generated method stub
		return expertDao.insertReview(review);
	}

}
