package kr.or.iei.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.model.dao.AdminDao;
import kr.or.iei.admin.model.vo.MemberPageData;
import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.admin.model.vo.ReportPageData;
import kr.or.iei.board.model.dao.BoardDao;
import kr.or.iei.member.model.vo.Member;

@Service("adminService")
public class AdminService {
	
	@Autowired
	@Qualifier("adminDao")
	private AdminDao adminDao;
	
	@Autowired
	@Qualifier("boardDao")
	private BoardDao boardDao;
	
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
      
      System.out.println("ADMINSERVICE 01 : " + list);
      
      //전체 신고 갯수
      int totCnt = adminDao.selectAllReportCount();
      
      //전체 페이지 갯수
      int totPage = 0;
      if(totCnt % viewReportCnt > 0) {
         totPage = totCnt / viewReportCnt + 1;
      } else {
         totPage = totCnt / viewReportCnt;
      }
      
      //페이지 네비게이션 사이즈      (1,2,3,4,5 or 6,7,8,9,10)
      int pageNaviSize = 5;
      
      //페이지 네비게이션 시작번호 설정 (1,2,3,4,5 == 1 or 6,7,8,9,10 == 6)
      int pageNo = ((reqPage-1) / pageNaviSize) * pageNaviSize + 1;
      
      //페이지 네비게이션 HTML
      String pageNavi = "<ul class = 'pagination circle-style'>";
      
      //이전버튼
      //시작번호 != 1 (시작번호 == 1 or 6 or 11 or 16 or 21 .....)
      if(pageNo != 1) {
         pageNavi += "<li>";
         pageNavi += "<a class='page-item' href='/admin/memberReportManage.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
         pageNavi += "<span class='material-icons'> < </span></a>";
         pageNavi += "</li>";
      }
      
      //페이지 네비게이션
      for(int i=0; i<pageNaviSize; i++) {
         pageNavi += "<li>";
         
         if(pageNo == reqPage) {
            pageNavi += "<a class='page-item active-page' href='/admin/memberReportManage.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
         } else {
            pageNavi += "<a class='page-item' href='/admin/memberReportManage.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
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
         pageNavi += "<a class = 'page-item' href='/admin/memberReportManage.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
         pageNavi += "<span class='material-icons'> > </span></a>";
         pageNavi += "</li>";
      }
      pageNavi += "</ul>";
      
      ReportPageData pd = new ReportPageData(list, pageNavi);
      
      System.out.println("AdminService : " + list);
      return pd;
   }

	
	public void insertReportByInfo(Report reportData) {
		// TODO Auto-generated method stub
		String suspect = "";
		
		switch(reportData.getReportType()) {
		case 0:
			suspect=boardDao.viewByBoardNo(reportData.getTargetNo()).getMemberNo();
			break;
		case 1:
			suspect=boardDao.commentBycommentNo(reportData.getTargetNo()).getMemberNo();
			break;
		}
		reportData.setSuspect(suspect);
		reportData.setReportResult("0");
		reportData.setFirstCategoryCd("D0001");
		reportData.setFirstCategoryNM("신고 코드 관리");
		reportData.setSecondCategoryCd("301_a0001");
		reportData.setSecondCategoryNM("신고 코드 종류");
		switch(reportData.getThirdCategoryCd()) {
		case "A_301_a0001":
			reportData.setThirdCategoryNM("0. 성적 수치심이나 불쾌감을 유발");
			break;
		case "A_301_a0002":
			reportData.setThirdCategoryNM("1. 비방 또는 음해 목적");
			break;
		case "A_301_a0003":
			reportData.setThirdCategoryNM("2. 영리목적으로 개인 사업정보 노출");
			break;
		case "A_301_a0004":
			reportData.setThirdCategoryNM("3. 허위사실 유포");
			break;
		case "A_301_a0005":
			reportData.setThirdCategoryNM("4. 동일한 글을 여러번 작성(3회 이상)");
			break;
		case "A_301_a0006":
			reportData.setThirdCategoryNM("5. 폭력, 비행, 사행심을 조장");
			break;
		case "A_301_a0007":
			reportData.setThirdCategoryNM("6. 본인 또는 타인의 개인정보 노출");
			break;
		case "A_301_a0008":
			reportData.setThirdCategoryNM("7. 권리침해");
			break;
		case "A_301_a0009":
			reportData.setThirdCategoryNM("8. 게시판 주제에 맞지 않는 게시글");
			break;
		}
		adminDao.insertReportByInfo(reportData);
	}

	//관리자페이지 -> 회원관리 - 회원정보 + 신고한 횟수, 신고받은 횟수, 접근제한 횟수 불러오기
	public MemberPageData selectWholeMemberList(int reqPage, String searchName) {
		int viewMemberCnt = 10;
	      
      int end = reqPage * viewMemberCnt;
      int start = end - viewMemberCnt + 1;
      
      HashMap<String, Integer> map = new HashMap<String, Integer>();
      map.put("start", start);
      map.put("end", end);
      
      //전체회원 리스트
      ArrayList<Member> list = (ArrayList<Member>) adminDao.selectWholeMemberList(map);
      
      System.out.println("전체회원리스트 : " + list);
      
      //전체 회원 수
      int totCnt = adminDao.selectWholeMemberCount();
      
      //전체 페이지 갯수
      int totPage = 0;
      if(totCnt % viewMemberCnt > 0) {
         totPage = totCnt / viewMemberCnt + 1;
      } else {
         totPage = totCnt / viewMemberCnt;
      }
      
      //페이지 네비게이션 사이즈      (1,2,3,4,5 or 6,7,8,9,10)
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
         pageNavi += "<span class='material-icons'> < </span></a>";
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
         pageNavi += "<span class='material-icons'> > </span></a>";
         pageNavi += "</li>";
      }
      pageNavi += "</ul>";
      
      MemberPageData pd = new MemberPageData(list, pageNavi);
      
      System.out.println("AdminService 전체회원리스트 : " + list);
      
      return pd;
	}
}
