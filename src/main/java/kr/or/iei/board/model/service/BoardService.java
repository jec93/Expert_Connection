package kr.or.iei.board.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.iei.board.model.dao.BoardDao;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.board.model.vo.BoardFile;
import kr.or.iei.board.model.vo.BoardPageData;
import kr.or.iei.board.model.vo.CommentPageData;
import kr.or.iei.board.model.vo.CommentReact;
import kr.or.iei.board.model.vo.MoveStin;

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
	public int insertBoard(Board board, MultipartFile[] files, HttpServletRequest request) {
        // 게시글 번호 생성
        String boardNo = boardDao.createBoardNo();

        // 게시글 번호 설정
        board.setBoardNo(boardNo);

        // 게시글 데이터 삽입
        int result = boardDao.insertBoard(board);

        if (result > 0 && files != null) {
            // 파일 저장 및 삽입 처리
            List<BoardFile> fileList = new ArrayList<>();
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");
                    String originalFileName = file.getOriginalFilename();
                    String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                    String today = new SimpleDateFormat("yyyyMMdd").format(new Date());
                    int randomNum = new Random().nextInt(10000) + 1;
                    String filePath = fileName + "_" + today + "_" + randomNum + extension;

                    // 파일 저장
                    try {
                        File saveFile = new File(savePath + filePath);
                        file.transferTo(saveFile);

                        // 파일 정보 생성
                        BoardFile boardFile = new BoardFile();
                        boardFile.setBoardNo(boardNo);
                        boardFile.setFileName(originalFileName);
                        boardFile.setFilePath(filePath);

                        fileList.add(boardFile);
                    } catch (IOException e) {
                        e.printStackTrace();
                        throw new RuntimeException("파일 저장 실패: " + originalFileName, e);
                    }
                }
            }

            // 파일 정보 DB 삽입
            for (BoardFile file : fileList) {
                result = boardDao.insertBoardFileByFile(file);
                if (result < 1) {
                    throw new RuntimeException("파일 삽입 실패");
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
/*
	1독립적인 친구) 게시글 정보 수정
	2)서버에서 기존 파일 정보를 삭제하기 위한 조회
	3)기존 파일 정보 삭제
	4)업로드한 파일 정보 등록
*/
	public void updateBoard(Board board, String[] fileNames, MultipartFile[] addFiles, String[] delFileNos, HttpServletRequest request) {

        // 게시글 정보 업데이트
        boardDao.updateBoardByNewBoard(board);

        // 기존 파일 처리 (필요하면 삭제 또는 유지)
        if (delFileNos != null) {
            for (String fileNo : delFileNos) {
                boardDao.deleteFileById(fileNo);
            }
        }

        // 새 파일 저장
        if (addFiles != null) {
            for (MultipartFile addFile : addFiles) {
                if (!addFile.isEmpty()) {
                    String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");
                    String originalFileName = addFile.getOriginalFilename();
                    String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                    String today = new SimpleDateFormat("yyyyMMdd").format(new Date());
                    int randomNum = new Random().nextInt(10000) + 1;
                    String filePath = fileName + "_" + today + "_" + randomNum + extension;

                    try {
                        File saveFile = new File(savePath + filePath);
                        addFile.transferTo(saveFile);

                        BoardFile boardFile = new BoardFile();
                        boardFile.setBoardNo(board.getBoardNo());
                        boardFile.setFileName(originalFileName);
                        boardFile.setFilePath(filePath);

                        boardDao.insertBoardFileByFile(boardFile);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
	}

	public int insertCommentByComment(BoardComment comment) {
		// TODO Auto-generated method stub
		return boardDao.insertCommentByComment(comment);
	}

	public int deleteCommentByCommentNo(String commentNo) {
		// TODO Auto-generated method stub
		return boardDao.deleteCommentByCommentNo(commentNo);
	}

	public int updateCommentByComment(BoardComment comment) {
		// TODO Auto-generated method stub
		return boardDao.updateCommentByComment(comment);
	}

	public String[] chkLikeByComment(String boardNo, String commentNo, String memberNo, int like) {
	    String[] likeChkData = new String[2];
	    HashMap<String, String> infoNumMap = new HashMap<>();
	    infoNumMap.put("comment", commentNo);
	    infoNumMap.put("member", memberNo);

	    // 현재 사용자의 좋아요/싫어요 상태 조회
	    CommentReact commentReact = boardDao.chkLikeByComment(infoNumMap);
	    int result = 0;
	    String msg = "";

	    HashMap<String, Object> commentParamMap = new HashMap<>();
	    commentParamMap.put("commentNo", commentNo);

	    if (commentReact != null) {
	        if (commentReact.getCommentChk() == like) {
	            // 같은 값이면 취소
	            commentReact.setCommentChk(0);
	            result = boardDao.updReactByReact(commentReact);
	            if (result > 0) {
	                commentParamMap.put("like", like);
	                commentParamMap.put("newAction", false);
	                boardDao.updateCommentLikeByReact(commentParamMap);
	                msg = like == -1 ? "댓글 싫어요가 취소되었습니다." : "댓글 좋아요가 취소되었습니다.";
	            }
	        } else {
	            // 다른 값으로 변경
	            int oldLike = commentReact.getCommentChk();
	            commentReact.setCommentChk(like);
	            result = boardDao.updateComLikeByReact(commentReact);
	            if (result > 0) {
	                // 이전 상태 감소
	                commentParamMap.put("like", oldLike);
	                commentParamMap.put("newAction", false);
	                boardDao.updateCommentLikeByReact(commentParamMap);

	                // 새로운 상태 증가
	                commentParamMap.put("like", like);
	                commentParamMap.put("newAction", true);
	                boardDao.updateCommentLikeByReact(commentParamMap);
	                msg = like == -1 ? "댓글 싫어요가 완료되었습니다." : "댓글 좋아요가 완료되었습니다.";
	            }
	        }
	    } else {
	        // 처음 좋아요/싫어요를 누른 경우
	        CommentReact ractInfo = new CommentReact(commentNo, memberNo, like, 0);
	        result = boardDao.insertComLikeInfo(ractInfo);
	        if (result > 0) {
	            commentParamMap.put("like", like);
	            commentParamMap.put("newAction", true);
	            boardDao.updateCommentLikeByReact(commentParamMap);
	            msg = like == -1 ? "댓글 싫어요가 완료되었습니다." : "댓글 좋아요가 완료되었습니다.";
	        }
	    }

	    if (result > 0) {
	        likeChkData[0] = String.valueOf(result);
	        likeChkData[1] = msg;
	    }
	    return likeChkData;
	}
	
	//관리자페이지 게시판 구별 없이 모든 게시글 불러오기
	public BoardPageData selectAllBoardList(int reqPage) {
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
		/* map.put("boardType", boardType); */
		
		//게시글 리스트
		ArrayList<Board> list = (ArrayList<Board>) boardDao.selectAllboardList(map);
		
		System.out.println("boardService" + list);
		
		//전체 게시글 갯수
		int totCnt = boardDao.selectAllBoardCount();
		
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
			pageNavi += "<a class='page-item' href='/board/adminManageList.exco?reqPage=" + (pageNo - 1) + "'>이전</a>";
			pageNavi += "<span class='material-icons'>chevron_left</span></a>";
			pageNavi += "</li>";
		}
		
		//페이지 네비게이션
		for(int i=0; i<pageNaviSize; i++) {
			pageNavi += "<li>";
			
			if(pageNo == reqPage) {
				pageNavi += "<a class='page-item active-page' href='/board/adminManageList.exco?reqPage="+pageNo+"'>";
			} else {
				pageNavi += "<a class='page-item' href='/board/adminManageList.exco?reqPage="+pageNo+"'>"+pageNo + "</a>";
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
			pageNavi += "<a class = 'page-item' href='/board/adminManageList.exco?reqPage=" + pageNo+"'>";
			pageNavi += "<span class='material-icons'>chevron_right</span></a>";
			pageNavi += "</li>";
		}
		pageNavi += "</ul>";
		
		BoardPageData pd = new BoardPageData(list, pageNavi);
				
		return pd;
		
	}

	//관리자페이지 - 커뮤니티관리(모든 댓글 불러오기)
	public CommentPageData selectAllCommentList(Integer reqPage) {
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
		/* map.put("boardType", boardType); */
		
		//게시글 리스트
		ArrayList<BoardComment> list = (ArrayList<BoardComment>) boardDao.selectAllCommentList(map);
		
		System.out.println("boardService" + list);
		
		//전체 게시글 갯수
		int totCnt = boardDao.selectAllCommentCount();
		
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
			pageNavi += "<a class='page-item' href='/board/adminManageComment.exco?reqPage=" + (pageNo - 1) + "'>이전</a>";
			pageNavi += "<span class='material-icons'>chevron_left</span></a>";
			pageNavi += "</li>";
		}
		
		//페이지 네비게이션
		for(int i=0; i<pageNaviSize; i++) {
			pageNavi += "<li>";
			
			if(pageNo == reqPage) {
				pageNavi += "<a class='page-item active-page' href='/board/adminManageComment.exco?reqPage="+pageNo+"'>";
			} else {
				pageNavi += "<a class='page-item' href='/board/adminManageComment.exco?reqPage="+pageNo+"'>"+pageNo + "</a>";
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
			pageNavi += "<a class = 'page-item' href='/board/adminManageComment.exco?reqPage=" + pageNo+"'>";
			pageNavi += "<span class='material-icons'>chevron_right</span></a>";
			pageNavi += "</li>";
		}
		pageNavi += "</ul>";
		
		CommentPageData pd = new CommentPageData(list, pageNavi);
				
		return pd;
	}
}