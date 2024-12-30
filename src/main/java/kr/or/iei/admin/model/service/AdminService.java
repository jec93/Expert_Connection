package kr.or.iei.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.model.dao.AdminDao;
import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.admin.model.vo.ReportPageData;
import kr.or.iei.board.model.vo.BoardPageData;

@Service("adminService")
public class AdminService {
	
	@Autowired
	@Qualifier("adminDao")
	private AdminDao adminDao;

	//관리자페이지 - 신고내역 전체목록 조회
	public ReportPageData selectAllReportList(int reqPage, String searchName) {
		
		int viewReportCnt = 10;
		
		int end = reqPage * viewReportCnt;
		int start = end - viewReportCnt + 1;
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		//신고 리스트
		ArrayList<Report> list = (ArrayList<Report>) adminDao.selectAllReportList(map);
		
		//전체 신고 갯수
		int totCnt = adminDao.selectAllReportCount();
		
		//전체 페이지 갯수
		int totPage = 0;
		if(totCnt % viewReportCnt > 0) {
			totPage = totCnt / viewReportCnt + 1;
		} else {
			totPage = totCnt / viewReportCnt;
		}
		
		//페이지 네비게이션 사이즈		(1,2,3,4,5 or 6,7,8,9,10)
		int pageNaviSize = 5;
		
		//페이지 네비게이션 시작번호 설정 (1,2,3,4,5 == 1 or 6,7,8,9,10 == 6)
		int pageNo = ((reqPage-1) / pageNaviSize) * pageNaviSize + 1;
		
		//페이지 네비게이션 HTML
		String pageNavi = "<ul class = 'pagination circle-style'>";
		
		//이전버튼
		//시작번호 != 1 (시작번호 == 1 or 6 or 11 or 16 or 21 .....)
		if(pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/admin/memberManage.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
			pageNavi += "<span class='material-icons'>chevron_left</span></a>";
			pageNavi += "</li>";
		}
		
		//페이지 네비게이션
		for(int i=0; i<pageNaviSize; i++) {
			pageNavi += "<li>";
			
			if(pageNo == reqPage) {
				pageNavi += "<a class='page-item active-page' href='/admin/memberManage.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
			} else {
				pageNavi += "<a class='page-item' href='/admin/memberManage.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
			}
			pageNavi += pageNo + "</a></li>";
			
			pageNo++;
			
			if(pageNo > totPage) {
				break;
			}
		}
		
		//다음버튼
		if(pageNo <= totPage) {
			pageNavi += "<li>";
			pageNavi += "<a class = 'page-item' href='/admin/memberManage.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
			pageNavi += "<span class='material-icons'>chevron_right</span></a>";
			pageNavi += "</li>";
		}
		pageNavi += "</ul>";
		
		ReportPageData pd = new ReportPageData(list, pageNavi);
				
		return pd;
	}
	

}
