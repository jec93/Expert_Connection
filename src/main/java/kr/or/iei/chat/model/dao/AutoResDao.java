package kr.or.iei.chat.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.chat.model.vo.AutoRes;

@Repository("autoResDao")
public class AutoResDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	// 자동응답 리스트 가져오기
	public List<AutoRes> getResponseList(String memberNo) {
		return sqlSession.selectList("autoRes.getResponseList", memberNo);
	}

	// 새로운 자동응답 삽입
	public int insertResponse(AutoRes autoRes) {
		return sqlSession.insert("autoRes.insertResponse", autoRes);
	}

	// 자동응답 on / off 업데이트
	public int updateAutoResState(String memberNo, String state) {
        return sqlSession.update("autoRes.updateAutoResState", Map.of("memberNo", memberNo, "state", state));
	}

	public String getAutoResState(String memberNo) {
		return sqlSession.selectOne("autoRes.getAutoResState", memberNo);
	}

	public int deleteResponse(String responseNo) {
		return sqlSession.delete("autoRes.deleteResponse", responseNo);
	}

	public List<AutoRes> getExpertAutoResListByRoomId(String roomId) {
		return sqlSession.selectList("autoRes.getExpertAutoResListByRoomId", roomId);
	}
}
