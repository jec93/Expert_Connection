package kr.or.iei.expert.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.expert.model.vo.ExpertManagement;
import kr.or.iei.expert.model.vo.Review;
import kr.or.iei.expert.model.vo.IntroduceReaction;


@Repository("expertDao")
public class ExpertDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public ExpertIntroduce viewExpertInfoByMemberNo(String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("expertManagement.viewExpertInfoByMemberNo", memberNo);
	}

	public List<ExpertIntroduce> findExpertsByCategory(String categoryNm, String addr) {
		Map<String, Object> params = new HashMap<>();
		params.put("categoryNm", categoryNm);
		params.put("addr", addr);
		return sqlSession.selectList("expertManagement.findExpertsByCategory", params);
	}

	public int updateExpertContent(String memberNo, String title, String content) {
		Map<String, Object> params = new HashMap<>();
        params.put("memberNo", memberNo);
        params.put("title", title);
        params.put("content", content);
        return sqlSession.update("expertManagement.updateExpertContent", params);
	}

	public int updatePortfolio(ExpertIntroduce portfolio) {
		return sqlSession.update("expertManagement.updatePortfolio", portfolio);
	}

	public List<Review> readReviewListByIntroNo(String introNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("expertManagement.readReviewListByIntroNo",introNo);
	}

	public int insertReview(Review review) {
		// TODO Auto-generated method stub
		return sqlSession.insert("expertManagement.insertReview",review);
	}

	public int deleteReview(String reviewNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("expertManagement.deleteReview",reviewNo);
	}

	public IntroduceReaction getReviewReaction(HashMap<String, String> infoNumMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("expertManagement.getReviewReaction",infoNumMap);
	}

	public int insertReviewLikeInfo(IntroduceReaction introInfo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("expertManagement.insertReviewLikeInfo",introInfo);
	}

	public void updateIntroLikeByIntro(HashMap<String, Object> introParamMap) {
		// TODO Auto-generated method stub
		sqlSession.update("expertManagement.updateIntroLikeByIntro", introParamMap);
	}

	public int updIntroByReact(IntroduceReaction introduceReact) {
		// TODO Auto-generated method stub
		return sqlSession.update("expertManagement.updIntroByReact", introduceReact);
	}
}
