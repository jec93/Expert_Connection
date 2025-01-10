package kr.or.iei.common.emitter.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.common.emitter.model.vo.Notice;

@Repository("noticeDao")
public class NoticeDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	//알림 목록 저장하기
	public int saveNotification(Notice notice) {
		return sqlSession.insert("notice.saveNotifications", notice);		
	}

	//알림목록 가져오기
	public List<Notice> getNotifications(String memberNo) {
		return sqlSession.selectList("notice.getNotifications", memberNo);
	}

	//알림번호 생성
	public String createNoticeNo() {
		return sqlSession.selectOne("notice.createNoticeNo");
	}

}
