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
				String pageNavi = "<ul class = 'pagination circle-style'>";
				
				//이전버튼
				//시작번호 != 1 (시작번호 == 1 or 6 or 11 or 16 or 21 .....)
				if(pageNo != 1) {
					pageNavi += "<li>";
					pageNavi += "<a class='page-item' href='/board/list.exco?reqPage=" + (pageNo - 1) + "'>이전</a>";
					pageNavi += "<span class='material-icons'>chevron_left</span></a>";
					pageNavi += "</li>";
				}
				
				//페이지 네비게이션
				for(int i=0; i<pageNaviSize; i++) {
					pageNavi += "<li>";
					
					if(pageNo == reqPage) {
						pageNavi += "<a class='page-item active-page' href='/board/list.exco?reqPage="+pageNo+"&boardType="+boardType+"&boardTypeNm="+boardTypeNm+"'>";
					} else {
						pageNavi += "<a class='page-item' href='/board/list.exco?reqPage="+ pageNo + "&boardType="+boardType+"&boardTypeNm="+boardTypeNm+"'>"+pageNo + "</a>";
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
					pageNavi += "<a class = 'page-item' href='/board/list.exco?reqPage=" + pageNo + "&boardType="+boardType+"&boardTypeNm="+boardTypeNm+"'>";
					pageNavi += "<span class='material-icons'>chevron_right</span></a>";
					pageNavi += "</li>";
				}
				pageNavi += "</ul>";
				
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
		if(result>0) {
			for(BoardFile file : fileList) {
				file.setBoardNo(boardNo);
				
				result = boardDao.insertBoardFileByFile(file);
				
				if(result<1) {
					break;
				}
			}
		}
		return result;
	}

	public Board viewFrm(String boardNo, String commentChk) {
		// TODO Auto-generated method stub
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

	public Board connectView(String boardNo) {
		// TODO Auto-generated method stub
		//게시글 존재 확인
		Board board = boardDao.viewByBoardNo(boardNo);
		if(board != null) {
			ArrayList<BoardFile> fileList = (ArrayList<BoardFile>)boardDao.ReadFileByBoardNo(boardNo);
			board.setFileList(fileList);
		}
		return board;
	}

	public ArrayList<BoardFile> deleteBoardByBoardNo(String boardNo) {
		// TODO Auto-generated method stub
		//파일 존재 확인
		ArrayList<BoardFile> fileList = (ArrayList<BoardFile>)boardDao.ReadFileByBoardNo(boardNo);
		
		int result = boardDao.deleteBoardByBoardNo(boardNo);
		
		if(result>0) {
			return fileList;
		}
		return null;
	}

	public ArrayList<BoardFile> updateBoardByNewBoard(Board board, ArrayList<BoardFile> fileList) {
		// TODO Auto-generated method stub
		/*
		 1독립적인 친구) 게시글 정보 수정(tbl_notice)
		 2)서버에서 기존 파일 정보를 삭제하기 위한 조회
		 3)기존 파일 정보 삭제
		 4)업로드한 파일 정보 등록(tbl_notice_file)
		 */
		
		//1) 게시글 정보 수정
		int result = boardDao.updateBoardByNewBoard(board);
		
		ArrayList<BoardFile> delFileList = null;
		if(result > 0) {
			//2) 서버에서 기존 파일 정보를 삭제하기 위한 파일 리스트 조회
			delFileList = (ArrayList<BoardFile>)boardDao.ReadFileByBoardNo(board.getBoardNo());
			
			//3) 기존 파일 정보 DB에서 삭제 처리
			result = boardDao.deleteBoardFileByBoardNo(board.getBoardNo());
			
			System.out.println(fileList+"파일리스트");
			
			if(result>0 && fileList.size() > 0) {
				//4) 업로드한 파일 정보 DB에 등록 처리
				for(BoardFile insFile : fileList) {
					boardDao.insertBoardFileByFile(insFile);
				}
			}
		}
		return delFileList;
	}

}