package kr.or.iei.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.member.model.vo.Member;

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
	
	//신고테이블에 값 넣기
	public void insertReportByInfo(Report reportData) {
		// TODO Auto-generated method stub
		sqlSession.insert("report.insertReportByInfo",reportData);
	}

	//관리자페이지 -> 회원관리 - 회원정보 + 신고한 횟수, 신고받은 횟수, 접근제한 횟수 불러오기
	public List<Member> selectWholeMemberList(HashMap<String, Integer> map) {
		return sqlSession.selectList("report.selectWholeMemberList", map);
	}

	//관리자페이지 -> 사용자 + 전문가 전체회원수 조회
	public int selectWholeMemberCount() {
		return sqlSession.selectOne("report.selectWholeMemberCount");
	}
	
}
