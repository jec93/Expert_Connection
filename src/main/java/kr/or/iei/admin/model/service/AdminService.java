package kr.or.iei.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.model.dao.AdminDao;
import kr.or.iei.admin.model.vo.AccessRestriction;
import kr.or.iei.admin.model.vo.ExpertPageData;
import kr.or.iei.admin.model.vo.MemberPageData;
import kr.or.iei.admin.model.vo.Report;
import kr.or.iei.admin.model.vo.ReportPageData;
import kr.or.iei.board.model.dao.BoardDao;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.board.model.vo.BoardFile;
import kr.or.iei.category.controller.CategoryInitializer;
import kr.or.iei.category.model.dao.CategoryDao;
import kr.or.iei.category.model.vo.Category;
import kr.or.iei.member.model.vo.Expert;
import kr.or.iei.member.model.vo.Member;

@Service("adminService")
public class AdminService {
	
	@Autowired
	@Qualifier("adminDao")
	private AdminDao adminDao;
	
	@Autowired
	@Qualifier("boardDao")
	private BoardDao boardDao;
	
	@Autowired
	@Qualifier("categoryDao")
	private CategoryDao categoryDao;
	
	@Autowired
	@Qualifier("categoryInitial")
	private CategoryInitializer categoryInitializer;
	
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
      
      //System.out.println("ADMINSERVICE 01 : " + list);
      
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
		reportData.setReportResult("D");
		reportData.setFirstCategoryCd("D0001");
		reportData.setFirstCategoryNM("신고 코드 관리");
		reportData.setSecondCategoryCd("301_a0001");
		reportData.setSecondCategoryNM("신고 코드 종류");
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
	
	//관리자페이지 -> 신고대상 클릭시 해당 게시글로 이동
	public Board viewBoard(String boardNo, String commentChk) {
		Board board = boardDao.viewByBoardNo(boardNo);
		
		if(board != null) {
			int result = 0;
			
			//commentChk ==null인 것은 댓글을 작성하고 상세보기 이동하는 경우를 제외 모든 요청
			if(commentChk ==null) {
				//조회수 증가
				result= boardDao.updateReadByboardNo(boardNo);				
			}
			
			//commentChk != null인것은 댓글을 작성하고 상세보기 이동하는 경우에도, 파일 정보를 select 할 수 있도록
			 if(result>0 || commentChk != null) { ArrayList<BoardFile> fileList =
			 (ArrayList<BoardFile>)boardDao.ReadFileByBoardNo(boardNo);
			 board.setFileList(fileList);
			  
			 ArrayList<BoardComment> commentList = (ArrayList<BoardComment>)boardDao.readCommentListByBoardNo(boardNo);
			 board.setCommentList(commentList);
			 }
		}
		return board;
	}

	//댓글 번호로 댓글이 작성된 게시글 번호 조회
	public String searchBoardNoByCommentNo(String commentNo) {
		String boardNo = boardDao.searchBoardNoByCommentNo(commentNo);
		return boardNo;
	}

	//관리자페이지 -> 신고확인버튼 클릭시 팝업띄워주기
	public Report checkReport(String reportNo) {
		Report report = adminDao.checkReport(reportNo);
		return report;
	}

	//관리자페이지 -> 신고처리결과 D->Y로 업데이트하기
	public int updateReportResultbyReportNo(String reportNo) {
		int report = adminDao.updateReportResultToY(reportNo);
		return report;
	}
	
	//관리자페이지 -> 접근제한 테이블에 넣어주기 7일
	public int firstAccessRestriction(String reportNo, String memberNo) {
		//int updateAccessRestrict = adminDao.updateRestrictionCount(memberNo);
		
		int accessRestrict = adminDao.firstReportNo(reportNo);
		return accessRestrict;
	}

	//관리자페이지 -> 접근제한 테이블에 넣어주기 15일
	public int secondAccessRestriction(String reportNo, String memberNo) {
		//int updateAccessRestrict = adminDao.updateRestrictionCount(memberNo);
		
		int accessRestrict = adminDao.secondReportNo(reportNo);
		return accessRestrict;
	}
	
	//관리자페이지 -> 접근제한 테이블에 넣어주기 100년
	public int thirdAccessRestriction(String reportNo, String memberNo) {
		//int updateAccessRestrict = adminDao.updateRestrictionCount(memberNo);
		
		int accessRestrict = adminDao.thirdReportNo(reportNo);
		return accessRestrict;
	}

	//관리자페이지 -> 신고대상 게시글 삭제
	public int deleteBoardByBoardNo(String boardNo) {
		int delBoard = adminDao.deleteBoard(boardNo);
		return delBoard;
	}
	
	//관리자페이지 -> 신고대상 댓글 삭제
	public int deleteCommentByCommentNo(String commentNo) {
		int delComment = adminDao.deleteCommentByCommentNo(commentNo); 
		return delComment;
	}

	//관리자 페이지 -> 접근제한 테이블에 넣기 전 대상(회원)이 이미 정지상태인지 확인
	public int checkAccess(String memberNo, String reportNo) {
		System.out.println("접근제한 memberNo : " + memberNo);
		System.out.println("접근제한 reportNo : " + reportNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("reportNo", reportNo);	
		
		int check = adminDao.checkAccess(map);
		return check;
	}

	//관리자페이지 -> 신고처리결과 D->N로 업데이트하기
	public int updateReportResult(String reportNo) {
		int report = adminDao.updateReportResultToN(reportNo);
		return report;
	}

	//관리자페이지 -> 신고처리내역 목록 불러오기
	public ReportPageData selectAllReportResultList(Integer reqPage, String searchName) {
		int viewReportCnt = 10;
	      
	    int end = reqPage * viewReportCnt;
	    int start = end - viewReportCnt + 1;
	      
	    HashMap<String, Integer> map = new HashMap<String, Integer>();
	    map.put("start", start);
	    map.put("end", end);
	  
	    //신고 리스트
	    ArrayList<Report> list = (ArrayList<Report>) adminDao.selectAllReportResultList(map);
	  
	    //System.out.println("ADMINSERVICE 01 : " + list);
	  
	   //전체 처리한 신고 갯수
	   int totCnt = adminDao.selectAllReportResultCount();
	  
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
		   pageNavi += "<a class='page-item' href='/admin/reportResult.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
		   pageNavi += "<span class='material-icons'> < </span></a>";
		   pageNavi += "</li>";
	  }
	  
	  //페이지 네비게이션
	  for(int i=0; i<pageNaviSize; i++) {
		  pageNavi += "<li>";
	 
		  if(pageNo == reqPage) {
			  pageNavi += "<a class='page-item active-page' href='/admin/reportResult.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
		  } else {
			  pageNavi += "<a class='page-item' href='/admin/reportResult.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
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
		 pageNavi += "<a class = 'page-item' href='/admin/reportResult.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
		 pageNavi += "<span class='material-icons'> > </span></a>";
		 pageNavi += "</li>";
	  }
	  pageNavi += "</ul>";
	  
	  ReportPageData pd = new ReportPageData(list, pageNavi);
	  
	  //System.out.println("AdminService : " + list);
	  return pd;
	}


	public int updateCategoryBymdfInfo(String key, String code, String mdfName) {
		// TODO Auto-generated method stub
		HashMap<String, String> mdfDataMap = new HashMap<String, String>();
		mdfDataMap.put("key", key);
		mdfDataMap.put("code", code);
		mdfDataMap.put("mdfName", mdfName);
		int result = categoryDao.updateCategoryBymdfInfo(mdfDataMap);
		if(result > 0) {
			categoryInitializer.refreshCategories();
		}
		return result;
	}


	public int deleteCategory(String thirdCode) {
		// TODO Auto-generated method stub
		int result = categoryDao.deleteCategory(thirdCode);
		if(result>0) {
			categoryDao.deleteExpertManageByThird(thirdCode);
			categoryInitializer.refreshCategories();
		}

		return result;
	}


	public int insertCategory(String key, String firstCd, String secondCd, String categoryNm) {
		// TODO Auto-generated method stub
		HashMap<String, String> cateMap = new HashMap<String, String>();
		cateMap.put("key", key);
		cateMap.put("firstCd", firstCd);
		cateMap.put("secondCd", secondCd);
		cateMap.put("categoryNm", categoryNm);
		/*
		 	key값(바꾸고자 하는게 대/중/소 중 무엇인지)
			firstCode값(바꾸고자 하는 값이 대 일때 0, 중/소 일때 대분류의 코드)
			secondCode값 (바꾸고자 하는 값이 대/소 일때 0, 소일때 중분류의 코드)
			categoryNm값 (넣고자하는 카테고리의 이름)
		 
		    각 상황에 맞는 데이터를 제공해줄 기능이 필요하다 생각
		 	대분류 추가시 대분류 코드를 가져와서 1증가
		 	
		 	중분류 추가시 대분류 코드/이름, 중분류코드 가져와서 1증가
		 	
		 	소분류 추가시 대/중 분류 코드와 이름, 소분류 코드 가져와서 1증가
		 	(폐기~~~ 추후~~~~ 키값 3 고정만 들어옴) 
		 * */
		//늘리고자하는 소분류의 중분류(대분류는 포함됨)의 전체 정보를 가져옴
		ArrayList<Category> categoryInfo = (ArrayList<Category>)categoryDao.viewFiSeCategory(secondCd);
		System.out.println("크기"+categoryInfo.size());
		
		int tmp = 0;
		String newThirdCd ="";
		newThirdCd = categoryInfo.get(0).getThirdCategoryCd().substring(0,7);
		System.out.println(newThirdCd);
		for(Category c : categoryInfo) { //마지막 코드 확인
			String substringCd = c.getThirdCategoryCd().substring(7);
			System.out.println(substringCd);
			int integerCd = Integer.parseInt(substringCd);
			if(integerCd>tmp) {
				tmp = integerCd;
			}
		}
		String stringCd = String.format("%04d", tmp+1);
		newThirdCd += stringCd;
		cateMap.put("thirdCd", newThirdCd);
		System.out.println(newThirdCd);
		
		int result = categoryDao.insertCategory(cateMap);
		
		if(result>0) {
			//추가시 데이터 초기화
			categoryInitializer.refreshCategories();
		}
		return result;
	}
	
	//관리자페이지 - 승인예정 전문가 목록 조회
	public ExpertPageData selectExpectedExpertList(int reqPage, String searchName) {
		int viewExpertCnt = 10;
	      
	    int end = reqPage * viewExpertCnt;
	    int start = end - viewExpertCnt + 1;
	      
	    HashMap<String, Integer> map = new HashMap<String, Integer>();
	    map.put("start", start);
	    map.put("end", end);
	  
	    //전문가 리스트
	    ArrayList<Expert> list = (ArrayList<Expert>) adminDao.selectExpectedExpertList(map);
	  
	   //전체 승인예정 전문가 회원 수
	   int totCnt = adminDao.selectAllExpectedExpertCount();
	  
	   //전체 페이지 갯수
	   int totPage = 0;
	   if(totCnt % viewExpertCnt > 0) {
	      totPage = totCnt / viewExpertCnt + 1;
	   } else {
	      totPage = totCnt / viewExpertCnt;
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
		   pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
		   pageNavi += "<span class='material-icons'> < </span></a>";
		   pageNavi += "</li>";
	  }
	  
	  //페이지 네비게이션
	  for(int i=0; i<pageNaviSize; i++) {
		  pageNavi += "<li>";
	 
		  if(pageNo == reqPage) {
			  pageNavi += "<a class='page-item active-page' href='/admin/expertManagement.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
		  } else {
			  pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
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
		 pageNavi += "<a class = 'page-item' href='/admin/expertManagement.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
		 pageNavi += "<span class='material-icons'> > </span></a>";
		 pageNavi += "</li>";
	  }
	  pageNavi += "</ul>";
	  
	  ExpertPageData pd = new ExpertPageData(list, pageNavi);
	  
	  return pd;
	}

	//관리자페이지 - 승인완료 전문가 목록 조회
	public ExpertPageData selectApprovalExpertList(int reqPage, String searchName) {
		int viewExpertCnt = 10;
	      
	    int end = reqPage * viewExpertCnt;
	    int start = end - viewExpertCnt + 1;
	      
	    HashMap<String, Integer> map = new HashMap<String, Integer>();
	    map.put("start", start);
	    map.put("end", end);
	  
	    //전문가 리스트
	    ArrayList<Expert> list = (ArrayList<Expert>) adminDao.selectApprovalExpertList(map);
	  
	   //전체 승인완료 전문가 회원 수
	   int totCnt = adminDao.selectAllApprovalExpertCount();
	  
	   System.out.println(totCnt);
	   
	   //전체 페이지 갯수
	   int totPage = 0;
	   if(totCnt % viewExpertCnt > 0) {
	      totPage = totCnt / viewExpertCnt + 1;
	   } else {
	      totPage = totCnt / viewExpertCnt;
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
		   pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
		   pageNavi += "<span class='material-icons'> < </span></a>";
		   pageNavi += "</li>";
	  }
	  
	  //페이지 네비게이션
	  for(int i=0; i<pageNaviSize; i++) {
		  pageNavi += "<li>";
	 
		  if(pageNo == reqPage) {
			  pageNavi += "<a class='page-item active-page' href='/admin/expertManagement.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
		  } else {
			  pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
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
		 pageNavi += "<a class = 'page-item' href='/admin/expertManagement.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
		 pageNavi += "<span class='material-icons'> > </span></a>";
		 pageNavi += "</li>";
	  }
	  pageNavi += "</ul>";
	  
	  ExpertPageData pd = new ExpertPageData(list, pageNavi);
	  
	  return pd;
	}
	
	//관리자페이지 - 승인거절 전문가 목록 조회
	public ExpertPageData selectDeclineExpertList(int reqPage, String searchName) {
		int viewExpertCnt = 10;
	      
	    int end = reqPage * viewExpertCnt;
	    int start = end - viewExpertCnt + 1;
	      
	    HashMap<String, Integer> map = new HashMap<String, Integer>();
	    map.put("start", start);
	    map.put("end", end);
	  
	    //전문가 리스트
	    ArrayList<Expert> list = (ArrayList<Expert>) adminDao.selectDeclineExpertList(map);
	  
	   //전체 승인거절 전문가 회원 수
	   int totCnt = adminDao.selectAllDeclineExpertCount();
	  
	   //전체 페이지 갯수
	   int totPage = 0;
	   if(totCnt % viewExpertCnt > 0) {
	      totPage = totCnt / viewExpertCnt + 1;
	   } else {
	      totPage = totCnt / viewExpertCnt;
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
		   pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
		   pageNavi += "<span class='material-icons'> < </span></a>";
		   pageNavi += "</li>";
	  }
	  
	  //페이지 네비게이션
	  for(int i=0; i<pageNaviSize; i++) {
		  pageNavi += "<li>";
	 
		  if(pageNo == reqPage) {
			  pageNavi += "<a class='page-item active-page' href='/admin/expertManagement.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
		  } else {
			  pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
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
		 pageNavi += "<a class = 'page-item' href='/admin/expertManagement.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
		 pageNavi += "<span class='material-icons'> > </span></a>";
		 pageNavi += "</li>";
	  }
	  pageNavi += "</ul>";
	  
	  ExpertPageData pd = new ExpertPageData(list, pageNavi);
	  
	  return pd;
	}

	//관리자페이지 - 승인정지 전문가 목록 조회
	public ExpertPageData selectHoldExpertList(int reqPage, String searchName) {
		int viewExpertCnt = 10;
	      
	    int end = reqPage * viewExpertCnt;
	    int start = end - viewExpertCnt + 1;
	      
	    HashMap<String, Integer> map = new HashMap<String, Integer>();
	    map.put("start", start);
	    map.put("end", end);
	  
	    //전문가 리스트
	    ArrayList<Expert> list = (ArrayList<Expert>) adminDao.selectHoldExpertList(map);
	  
	   //전체 승인정지 전문가 회원 수
	   int totCnt = adminDao.selectAllHoldExpertCount();
	  
	   //전체 페이지 갯수
	   int totPage = 0;
	   if(totCnt % viewExpertCnt > 0) {
	      totPage = totCnt / viewExpertCnt + 1;
	   } else {
	      totPage = totCnt / viewExpertCnt;
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
		   pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage=" + (pageNo - 1) + "&searchName="+searchName+"'>";
		   pageNavi += "<span class='material-icons'> < </span></a>";
		   pageNavi += "</li>";
	  }
	  
	  //페이지 네비게이션
	  for(int i=0; i<pageNaviSize; i++) {
		  pageNavi += "<li>";
	 
		  if(pageNo == reqPage) {
			  pageNavi += "<a class='page-item active-page' href='/admin/expertManagement.exco?reqPage="+pageNo+"&searchName="+searchName+"'>";
		  } else {
			  pageNavi += "<a class='page-item' href='/admin/expertManagement.exco?reqPage="+ pageNo+ "&searchName="+searchName+"'>";
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
		 pageNavi += "<a class = 'page-item' href='/admin/expertManagement.exco?reqPage=" + pageNo + "&searchName="+searchName+"'>";
		 pageNavi += "<span class='material-icons'> > </span></a>";
		 pageNavi += "</li>";
	  }
	  pageNavi += "</ul>";
	  
	  ExpertPageData pd = new ExpertPageData(list, pageNavi);
	  
	  return pd;
	}

	//관리자페이지 - 전문가 승인 반려
	public int expertDecline(String receiveNo) {
		
		int result = adminDao.expertDecline(receiveNo);
		
		if (result > 0) {
			//이메일 발송하게해야함
		}
		
		return result;
	}
}
