package kr.or.iei.expert.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.expert.model.dao.ExpertDao;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.expert.model.vo.Review;
import kr.or.iei.expert.model.vo.IntroduceReaction;

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

	public int deleteReview(String reviewNo) {
		// TODO Auto-generated method stub
		return expertDao.deleteReview(reviewNo);
	}

	public String getReviewReaction(String introNo, String memberNo) {
		// TODO Auto-generated method stub
		HashMap<String, String> infoNumMap = new HashMap<>();
		infoNumMap.put("introNo", introNo);
		infoNumMap.put("memberNo", memberNo);
		IntroduceReaction intorReact = expertDao.getReviewReaction(infoNumMap);
		if(Objects.isNull(intorReact)) {			
			return null;
		}
		return String.valueOf(intorReact.getIntroReact());
	}

	public String[] updReviewLike(String introNo, String memberNo,String expertNo, int like) {
		// TODO Auto-generated method stub
		String[] likeChkData = new String[3];
		HashMap<String, String> infoNumMap = new HashMap<String, String>();
		infoNumMap.put("introNo", introNo);
		infoNumMap.put("memberNo", memberNo);
		
		//현 사용자 좋아요/싫어요 상태 조회
		IntroduceReaction introduceReact = expertDao.getReviewReaction(infoNumMap);
		int result = 0;
		String msg = "";
		
		HashMap<String, Object> introParamMap = new HashMap<String, Object>();
		introParamMap.put("introNo", introNo);
		
		if(introduceReact == null) {
			//처음 좋아요/싫어요 누른 경우
			IntroduceReaction introInfo = new IntroduceReaction(introNo, expertNo, memberNo, like, 0);
			result = expertDao.insertReviewLikeInfo(introInfo);
			if(result > 0) {
				introParamMap.put("like", like);
				introParamMap.put("newAction", true);
				//like값과 newAction(변화값)에 따른 데이터 수정
				expertDao.updateIntroLikeByIntro(introParamMap);
				msg = like == -1 ? "전문가 싫어요가 완료되었습니다." : "전문가 좋아요가 완료되었습니다.";
			}
		}else {
			if(introduceReact.getIntroReact() == 0) {
				//이부분은 좋아요/아쉬워요 취소후 다시 누를때 새로운 컬럼을 생성해버려서 추가함
				introduceReact.setIntroReact(like);
				result = expertDao.updIntroByReact(introduceReact);
				if(result > 0) {
					introParamMap.put("like", like);
					introParamMap.put("newAction", true);
					expertDao.updateIntroLikeByIntro(introParamMap);
					msg = like == -1 ? "전문가 싫어요가 완료되었습니다." : "전문가 좋아요가 완료되었습니다.";
				}
			}else {
				if(introduceReact.getIntroReact() == like) {
					//같은 값이면 취소
					introduceReact.setIntroReact(0);
					result = expertDao.updIntroByReact(introduceReact);
					if(result>0) {
						introParamMap.put("like", like);
						introParamMap.put("newAction", false);
						expertDao.updateIntroLikeByIntro(introParamMap);
						msg = like == -1 ? "전문가 싫어요가 취소되었습니다." : "전문가 좋아요가 취소되었습니다.";
						like = 0; //최종 유저 선호도 값 없음 반영
					}
				}else {
					//다른값으로 변경
					int oldLike = introduceReact.getIntroReact();
					introduceReact.setIntroReact(like);
					result = expertDao.updIntroByReact(introduceReact);
					if(result>0) {
						//이전 상태 감소
						introParamMap.put("like", oldLike);
						introParamMap.put("newAction", false);
						expertDao.updateIntroLikeByIntro(introParamMap);
						
						//새로운 상태 증가
						introParamMap.put("like", like);
						introParamMap.put("newAction", true);
						expertDao.updateIntroLikeByIntro(introParamMap);
						msg= like == -1 ? "전문가 싫어요가 완료되었습니다." : "전문가 좋아요가 완료되었습니다.";
					}
				}
			}
		}
		if(result>0) {
			likeChkData[0] = String.valueOf(result);
			likeChkData[1] = msg;
			likeChkData[2] = String.valueOf(like);
		}
		return likeChkData;
	}

}
