package kr.or.iei.common.emitter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.common.emitter.model.dao.NoticeDao;
import kr.or.iei.common.emitter.model.vo.Notice;

@Service("noticeService")
public class NoticeService {
	
	@Autowired
	@Qualifier("noticeDao")
	private NoticeDao noticeDao;
	
	//알림정보 저장
	public int saveNotification(Notice notice) {
		//알림번호 생성
		String noticeNo = noticeDao.createNoticeNo();
		
		//알림번호 설정
		notice.setNoticeNo(noticeNo);
		 
		//알림 정보 저장		
		int result = noticeDao.saveNotification(notice);
		
		return result;
	}
	
	//알림정보 가져오기
	public List<Notice> getNotifications(String memberNo) {
		return noticeDao.getNotifications(memberNo);
	}
	
}
