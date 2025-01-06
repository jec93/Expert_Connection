package kr.or.iei.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.admin.model.vo.AccessRestriction;
import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.board.model.vo.Board;
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
	
	//관리자페이지 - 신고내역 결과목록 조회
	public List<Report> selectAllReportResultList(HashMap<String, Integer> map) {
		return sqlSession.selectList("report.selectAllReportResultList", map);
	}
	
	//관리자페이지 - 전체 신고횟수 조회
	public int selectAllReportCount() {
		return sqlSession.selectOne("report.selectAllReportCount");
	}

	//관리자페이지 - 전체 신고처리갯수 조회
	public int selectAllReportResultCount() {
		return sqlSession.selectOne("report.selectAllReportResultCount");
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

	//관리자페이지 -> 신고내역 확인
	public Report checkReport(String reportNo) {
		return sqlSession.selectOne("report.checkReport", reportNo);
	}

	//관리자페이지 -> 신고내역 업데이트 Y(진짜신고)
	public int updateReportResultToY(String reportNo) {
		return sqlSession.update("report.updateReportToY", reportNo);
	}

	//관리자페이지 -> 신고내역 업데이트 N(허위신고)
	public int updateReportResultToN(String reportNo) {
		return sqlSession.update("report.updateReportToN", reportNo);
	}

	//관리자페이지 -> 접근제한 테이블에 넣어주기 7일
	public int firstReportNo(String reportNo) {
		return sqlSession.insert("report.firstReportNo", reportNo);
	}
	
	//관리자페이지 -> 접근제한 테이블에 넣어주기 15일
	public int secondReportNo(String reportNo) {
		return sqlSession.insert("report.secondReportNo", reportNo);
	}
	
	//관리자페이지 -> 접근제한 테이블에 넣어주기 15일
	public int thirdReportNo(String reportNo) {
		return sqlSession.insert("report.thirdReportNo", reportNo);
	}

	//관리자페이지 -> 신고대상 게시글/댓글 삭제
	public int deleteTarget(HashMap<String, Integer> map) {
		return sqlSession.delete("report.deleteTarget", map);
	}

	//관리자페이지 -> 신고대상 게시글 삭제
	public int deleteBoard(String boardNo) {
		return sqlSession.delete("report.deleteBoard", boardNo);
	}
	
	//관리자페이지 -> 신고대상 댓글 삭제
	public int deleteCommentByCommentNo(String commentNo) {
		return sqlSession.delete("report.deleteComment", commentNo);
	}

	//관리자페이지 -> 접근제한 테이블에 넣기 전, 대상(회원)이 이미 정지상태인지 조회
	public int checkAccess(Map<String, Object> map) {
		return sqlSession.selectOne("report.checkAccess", map);
	}

	/*
	 * //관리자페이지 -> 접근제한횟수 증가 public int updateRestrictionCount(String memberNo) {
	 * return sqlSession.update("report.updateRestrictionCount", memberNo); }
	 */
	
}
