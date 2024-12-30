package kr.or.iei.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.admin.model.vo.Report;

@Repository("adminDao")
public class AdminDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	//관리자페이지 - 신고내역 목록 조회
	public List<Report> selectAllReportList(HashMap<String, Integer> map) {
		return sqlSession.selectList("report.selectAllReportList", map);
	}
	
	//관리자페이지 - 전체 신고횟수 조회
	public int selectAllReportCount() {
		return sqlSession.selectOne("report.selectAllReportCount");
	}
	
}
