package kr.or.iei.expert.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.expert.model.vo.ExpertManagement;


@Repository("expertDao")
public class ExpertDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	public List<ExpertManagement> getExpertList() {
		return sqlSession.selectList("expertManagement.selectExpertList");
	}

	public ExpertManagement getExpertDetail(String receiveNo) {
		return sqlSession.selectOne("expertManagement.getExpertDetail", receiveNo);
	}

}
