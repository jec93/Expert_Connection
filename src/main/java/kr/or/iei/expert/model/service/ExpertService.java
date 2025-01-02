package kr.or.iei.expert.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.expert.model.dao.ExpertDao;
import kr.or.iei.expert.model.vo.ExpertIntroduce;
import kr.or.iei.expert.model.vo.ExpertManagement;

@Service("expertService")
public class ExpertService {

	@Autowired
	private ExpertDao expertDao;
	
	public ArrayList<ExpertManagement> getExpertList(){
		return (ArrayList<ExpertManagement>) expertDao.getExpertList();
	}

	//전문가 상세페이지 정보 가져오기
	public ExpertManagement getExpertDetail(String receiveNo) {
		return expertDao.getExpertDetail(receiveNo);
	}

	public ExpertIntroduce viewExpertInfoByMemberNo(String memberNo) {
		return expertDao.viewExpertInfoByMemberNo(memberNo);
	}
}
