package kr.or.iei.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.chat.model.dao.AutoResDao;
import kr.or.iei.chat.model.vo.AutoRes;

@Service("autoResService")
public class AutoResService {
	
	@Autowired
	@Qualifier("autoResDao")
	private AutoResDao autoResDao;

	// 자동응답 리스트 가져오기
	public ArrayList<AutoRes> getResponseList(String memberNo) {
		return (ArrayList<AutoRes>)autoResDao.getResponseList(memberNo);
	}

	// 새로운 자동응답 삽입
	public boolean saveResponse(AutoRes autoRes) {
		return autoResDao.insertResponse(autoRes) > 0;
	}

	// 자동응답 on / off 업데이트
	public boolean updateAutoResState(String memberNo, String state) {
		return autoResDao.updateAutoResState(memberNo, state) > 0;
	}
	
	// 자동응답 on / off 상태 조회
	public String getAutoResState(String memberNo) {
		return autoResDao.getAutoResState(memberNo);
	}

	public boolean deleteResponse(String responseNo) {
		return autoResDao.deleteResponse(responseNo) > 0;
	}

}
