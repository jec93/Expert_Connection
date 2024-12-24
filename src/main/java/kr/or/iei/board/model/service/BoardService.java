package kr.or.iei.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.board.model.dao.BoardDao;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.board.model.vo.BoardFile;
import kr.or.iei.board.model.vo.BoardPageData;

@Service("boardService")
public class BoardService {

	@Autowired
	@Qualifier("boardDao")
	private BoardDao boardDao;
	
	
	//게시판 목록 조회
	public BoardPageData selectBoardList(int boardType, int reqPage, String boardTypeNm) {
		//한 페이지에서 보여줄 게시글의 갯수
				int viewboardCnt = 10;
				
				System.out.println("서비스 boardType : " + boardType);
				System.out.println("서비스 reqPage : " + reqPage);
				System.out.println("서비스 boardTypeNm : " + boardTypeNm);
				
				//게시글 시작번호, 게시글 끝 번호
				/*
				 요청 페이지 		끝번호		시작번호
				 	1			 10			  1
				 	2			 20			  11
				 	3			 30			  21
				 */
				int end = reqPage * viewboardCnt;
				int start = end - viewboardCnt + 1;
				
				HashMap<String, Integer> map = new HashMap<String, Integer>();
				map.put("start", start);
				map.put("end", end);
				map.put("boardType", boardType);
				
				//게시글 리스트
				ArrayList<Board> list = (ArrayList<Board>) boardDao.selectboardList(map);
				
				//전체 게시글 갯수
				int totCnt = boardDao.selectboardCount(boardType);
				
				//전체 페이지 갯수
				int totPage = 0;
				/*
				전체 게시글 갯수		전체 페이지 갯수
					16					 2
					20					 2
					29					 3
				 */
				
				if(totCnt % viewboardCnt > 0) {
					totPage = totCnt / viewboardCnt + 1;
				} else {
					totPage = totCnt / viewboardCnt;
				}
				
				//페이지 네비게이션 사이즈		(1,2,3,4,5 or 6,7,8,9,10)
				int pageNaviSize = 5;
				
				//페이지 네비게이션 시작번호 설정 (1,2,3,4,5 == 1 or 6,7,8,9,10 == 6)
				int pageNo = ((reqPage-1) / pageNaviSize) * pageNaviSize + 1;
				
				//페이지 네비게이션 HTML
				String pageNavi = "";
				
				//이전버튼
				//시작번호 != 1 (시작번호 == 1 or 6 or 11 or 16 or 21 .....)
				if(pageNo != 1) {
					pageNavi +="<a href='/board/list.exco?reqPage=" + (pageNo - 1) + "'>이전</a>";
				}
				
				//페이지 네비게이션
				for(int i=0; i<pageNaviSize; i++) {
					if(pageNo == reqPage) {
						pageNavi += "<span>" + pageNo + "</span>";
					} else {
						pageNavi += "<a href='/board/list.exco?reqPage="+ pageNo + "&boardType="+boardType+"&boardTypeNm="+boardTypeNm+"'>"+pageNo + "</a>";
					}
					
					pageNo++;
					
					if(pageNo > totPage) {
						break;
					}
				}
				
				//다음버튼
				if(pageNo <= totPage) {
					pageNavi += "<a href='/board/list.exco?reqPage=" + pageNo + "&boardType="+boardType+"&boardTypeNm="+boardTypeNm+"'>다음</a>";
				}
				
				BoardPageData pd = new BoardPageData(list, pageNavi);
						
				return pd;
	}

	@Transactional // 별도메소드를 호출해도 트랜젝션 안됨.
	public int insertBoard(Board board, ArrayList<BoardFile> fileList) {
		// TODO Auto-generated method stub
		//게시글 번호 생성
		String boardNo = boardDao.createBoardNo();
		
		//게시글 번호 삽입
		board.setBoardNo(boardNo);
		int result = boardDao.insertBoard(board);
		return result;
	}

	public Board viewFrm(String boardNo, String commentChk) {
		// TODO Auto-generated method stub
		Board board = boardDao.viewByBoardNo(boardNo);
		
		if(board != null) {
			int result = 0;
			
			//commentChk ==null인 것은 댓글을 작성하고 상세보기 이동하는 경우를 제외 모든 요청
			if(commentChk ==null) {
				result= boardDao.updateReadByboardNo(boardNo);				
			}
			System.out.println(commentChk);
			System.out.println(result);
			
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

}
