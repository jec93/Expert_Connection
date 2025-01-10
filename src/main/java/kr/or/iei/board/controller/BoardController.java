package kr.or.iei.board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.iei.board.model.service.BoardService;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.board.model.vo.BoardFile;
import kr.or.iei.board.model.vo.BoardPageData;
import kr.or.iei.board.model.vo.BoardType;
import kr.or.iei.board.model.vo.CommentPageData;
import kr.or.iei.common.emitter.Emitter;
import kr.or.iei.common.emitter.model.service.NoticeService;
import kr.or.iei.common.emitter.model.vo.Notice;

@Controller("boardController")
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	@Qualifier("boardService")
	private BoardService boardservice;
	
	@Autowired
	private Emitter emitter;
	
	@Autowired
	@Qualifier("noticeService")
	private NoticeService noticeService;

	// 게시글 목록 조회
	@GetMapping("list.exco")
	public String getList(Integer reqPage, Integer boardType, String boardTypeNm, Model model) {
		// null 체크 및 예외 처리
		if (reqPage == null || boardType == null || boardTypeNm == null || boardTypeNm.isEmpty()) {
			throw new IllegalArgumentException("요청 페이지(reqPage), 게시판 분류(boardType), 게시판 이름(boardTypeNm)는 필수입니다.");
		}

		int typeName;
		try {
			// boardTypeNm을 숫자로 변환
			typeName = Integer.parseInt(boardTypeNm);
		} catch (NumberFormatException e) {
			// 변환 실패 시 예외 던지기
			throw new IllegalArgumentException("게시판 이름(boardTypeNm)은 숫자여야 합니다.");
		}

		// BoardPageData 호출
		BoardPageData pd = boardservice.selectBoardList(boardType, reqPage, boardTypeNm);

		// Model에 데이터 추가
		model.addAttribute("boardList", pd.getList());
		model.addAttribute("boardTypeNm", BoardType.type[typeName]); // 숫자로 변환된 값을 사용
		model.addAttribute("pageNavi", pd.getPageNavi());
		model.addAttribute("boardType", boardType);

		return "board/boardList";
	}

	// 게시글 작성
	@GetMapping("writeFrm.exco")
	public String getWriteFrm(Integer boardType, String boardTypeNm, Model model) {
		if (boardType == null) {
			throw new IllegalArgumentException("게시판 정보를 가져오는중 에러");
		}
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardTypeNm", boardTypeNm);
		return "board/boardWrite";
	}

	//
	@PostMapping("write.exco")
	public String insertBoard(HttpServletRequest request, MultipartFile[] files, Board board, Notice notice) {
		if (board.getBoardWriter().trim().isEmpty()) {
			throw new IllegalArgumentException("작성자 이름이 비었습니다.");
		}
		if (board.getBoardTitle().trim().isEmpty()) {
			throw new IllegalArgumentException("게시판 제목이 비었습니다.");
		}
		if (board.getBoardContent().trim().isEmpty()) {
			throw new IllegalArgumentException("게시판 내용이 비었습니다.");
		}

		// 서비스 호출
		int result = boardservice.insertBoard(board, files, request);

		if (result > 0) {
			request.setAttribute("title", "성공");
			request.setAttribute("msg", board.getBoardTypeNm() + "이 작성되었습니다.");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "list.exco?reqPage=1&boardType=" + board.getBoardType() + "&boardTypeNm=" + board.getBoardType());
			
			//게시글 URL 생성
			String url = "/board/viewBoardFrm.exco?boardNo=" + board.getBoardNo() + "&boardType"+ board.getBoardType();
			
			
			// 알림 전송 및 저장
	        String notificationMessage = board.getBoardTypeNm() +"에 새 게시글이 작성되었습니다.";
	        emitter.sendBroadcastEvent(notificationMessage, url);
	        
	        // Notice 객체 생성 후 저장
	        if (notificationMessage != null && !notificationMessage.trim().isEmpty()) {
	            notice = new Notice();
	            notice.setMemberNo(board.getMemberNo());
	            notice.setMessage(notificationMessage);
	            notice.setUrl(url);
	            
	            noticeService.saveNotification(notice);
	            
	        } else {
	            throw new IllegalArgumentException("알림 메시지가 비어 있습니다.");
	        }
		}
		return "common/msg";
	}

	@GetMapping("viewBoardFrm.exco")
	public String viewFrm(String boardNo, String commentChk, Model model) { // 댓글 작성 후 돌아오는 화면에서 조회수를 늘리지 않기 위한
																			// commentChk변수
		Board board = boardservice.viewFrm(boardNo, commentChk);
		if (board == null) {
			return "redirect:/";
		}
		model.addAttribute("board", board);
		return "board/view";
	}

	@GetMapping("updateFrm.exco")
	public String updateFrm(String boardNo, Model model) {
		// 기존 게시글 정보 가져오기(viewFrm)의 경우 접근시 조회수가 증가하므로 다르게 접근
		Board board = boardservice.connectView(boardNo);
		board.setBoardTypeNm(BoardType.type[board.getBoardType()]);
		model.addAttribute("board", board);
		return "board/updateFrm";
	}

	@PostMapping("update.exco")
	public String updateBoard(@RequestParam("boardNo") String boardNo, @RequestParam("boardTitle") String boardTitle,@RequestParam("boardType") Integer boardType,
			@RequestParam("boardContent") String boardContent,
			@RequestParam(value = "files", required = false) MultipartFile[] files, // 기존 파일을 MultipartFile[]로 받음
			@RequestParam(value = "addFiles", required = false) MultipartFile[] addFiles,
			@RequestParam(value = "delFileNo", required = false) String[] delFileNos, HttpServletRequest request) {

		// 기존 파일 이름을 문자열 배열로 변환
		String[] fileNames = null;
		if (files != null) {
			fileNames = Arrays.stream(files).filter(file -> !file.isEmpty()).map(MultipartFile::getOriginalFilename)
					.toArray(String[]::new);
		}

		// 게시글 내용 수정 작업
		Board board = new Board();
		board.setBoardNo(boardNo);
		board.setBoardTitle(boardTitle);
		board.setBoardContent(boardContent);
		board.setBoardType(boardType);

		boardservice.updateBoard(board, fileNames, addFiles, delFileNos, request);

		return "redirect:/board/list.exco?reqPage=1&boardType="+boardType+"&boardTypeNm="+boardType;
	}

	@GetMapping(value = "fileDown.exco", produces = "application/octet-stream;")
	public void boardFileDown(HttpServletRequest request, HttpServletResponse response, String fileName,
			String filePath) {
		// 파일 위치 절대 경로
		String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");

		// 파일 다운로드를 위한 보조 스트림 선언
		BufferedOutputStream bos = null; // 읽어들인 파일을 사용자에게 내보내기(다운로드) 위한 보조스트림
		BufferedInputStream bis = null; // 서버에서 파일을 읽어들이기 위한 보조 스트림

		try {
			FileInputStream fis = new FileInputStream(savePath + filePath);

			// 보조스트림과 주스트림 연결
			bis = new BufferedInputStream(fis);

			// 파일을 내보내기 위한 스트림 생성
			ServletOutputStream sos = response.getOutputStream();

			// 보조스트림과 주스트림 연결
			bos = new BufferedOutputStream(sos);

			// 다운로드 파일명 설정
			String resFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");

			// 브라우저에게 다운로드 지시 및 다운로드 파일명 지정
			response.setHeader("Content-Disposition", "attachment; filename=" + resFileName);

			while (true) {
				int read = bis.read(); // 바이트 단위로 파일 데이터 read
				if (read == -1) { // 읽을 데이터 존재하지 않을 때 반복문 종료
					break;
				} else {
					bos.write(read);
				}
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				bos.close();
				bis.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@GetMapping("delete.exco")
	public String deleteBoardByBoardNo(String boardNo, int boardType, HttpServletRequest request) {
		ArrayList<BoardFile> fileList = boardservice.deleteBoardByBoardNo(boardNo);
		if (fileList != null && fileList.size() > 0) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");

			for (BoardFile file : fileList) {
				File delFile = new File(savePath + file.getFilePath());

				if (delFile.exists()) {
					delFile.delete();
				}
			}
		}
		return "redirect:/board/list.exco?reqPage=1&boardType=" + boardType + "&boardTypeNm=" + boardType;
	}
	
	//관리자페이지 - 1:1문의 목록 불러오기
	@GetMapping("adminPage.exco")
	public String getListAdminPage(Integer reqPage, Integer boardType, String boardTypeNm, Model model) {
		
	    // null 체크 및 예외 처리
	    if (reqPage == null || boardType == null || boardTypeNm == null || boardTypeNm.isEmpty()) {
	        throw new IllegalArgumentException("요청 페이지(reqPage), 게시판 분류(boardType), 게시판 이름(boardTypeNm)는 필수입니다.");
	    }

	    int typeName;
	    try {
	        // boardTypeNm을 숫자로 변환
	        typeName = Integer.parseInt(boardTypeNm);
	    } catch (NumberFormatException e) {
	        // 변환 실패 시 예외 던지기
	        throw new IllegalArgumentException("게시판 이름(boardTypeNm)은 숫자여야 합니다.");
	    }

	    // BoardPageData 호출
	    BoardPageData pd = boardservice.selectBoardList(boardType, reqPage, boardTypeNm);

	    // Model에 데이터 추가
	    model.addAttribute("boardList", pd.getList());
	    model.addAttribute("boardTypeNm", BoardType.type[typeName]); // 숫자로 변환된 값을 사용
	    model.addAttribute("pageNavi", pd.getPageNavi());
	    model.addAttribute("boardType", boardType);

	    return "member/mypage";
	}
	
    @GetMapping("insertComment.exco")
    public String isertComment(String boardNo, String memberNo, String commentContent, Board board, Model model) {
    	if (commentContent == null || commentContent.trim().isEmpty()) {
			// 이전 페이지(뷰) URL 가져오기
    		model.addAttribute("title", "오류");
    		model.addAttribute("msg", "내용입력해주세요");
    		model.addAttribute("icon", "error");
    		model.addAttribute("loc", "viewBoardFrm.exco?boardNo="+boardNo);
			return "common/msg";
		}
    	
    	BoardComment comment = new BoardComment();
    	comment.setBoardNo(boardNo);
    	comment.setMemberNo(memberNo);
    	comment.setCommentContent(commentContent);
    	int result = boardservice.insertCommentByComment(comment);
    	
    	if(result>0) {
    		model.addAttribute("title", "성공");
    		model.addAttribute("msg", "댓글 등록 완료");
    		model.addAttribute("icon", "success");
    		model.addAttribute("loc", "viewBoardFrm.exco?boardNo="+boardNo+"&commentChk=1");
    		
    		/*
    		// 알림 전송
    		String notificationMessage = board.getBoardTitle() +"에 댓글이 등록 되었습니다.";
    		emitter.sendBroadcastEvent(notificationMessage);
    		*/
    		
    	}else {
    		model.addAttribute("title", "오류");
    		model.addAttribute("msg", "댓글 등록 실패");
    		model.addAttribute("icon", "error");
    		model.addAttribute("loc", "viewBoardFrm.exco?boardNo="+boardNo+"&commentChk=1");    		
    	}
		return "common/msg";
    }
    
    @GetMapping("deleteComment.exco")
    public String deleteComment(String commentNo, String boardNo, Model model) {
    	int result = boardservice.deleteCommentByCommentNo(commentNo);
    	if(result>0) {
    		model.addAttribute("title", "성공");
    		model.addAttribute("msg", "댓글 삭제 완료");
    		model.addAttribute("icon", "success");
    		model.addAttribute("loc", "viewBoardFrm.exco?boardNo="+boardNo+"&commentChk=1");
    	}else {
    		model.addAttribute("title", "오류");
    		model.addAttribute("msg", "댓글 삭제 실패");
    		model.addAttribute("icon", "error");
    		model.addAttribute("loc", "viewBoardFrm.exco?boardNo="+boardNo+"&commentChk=1");    		
    	}
		return "common/msg";
    }
    
    @PostMapping("updateComment.exco")
    public String updateCommentByComment(String commentNo, String boardNo, String commentContent, Model model) {
    	BoardComment comment = new BoardComment();
    	comment.setCommentNo(commentNo);
    	comment.setCommentContent(commentContent);
    	
    	int result = boardservice.updateCommentByComment(comment);
    	if(result >0 ) {
    		model.addAttribute("title","알림");
    		model.addAttribute("msg","댓글 수정이 완료되었습니다.");
    		model.addAttribute("icon","success");
    		model.addAttribute("loc","viewBoardFrm.exco?boardNo="+boardNo+"&commentChk=1");
    	}else {
    		model.addAttribute("title","에러");
    		model.addAttribute("msg","댓글 수정중 오류 발생");
    		model.addAttribute("icon","error");
    		model.addAttribute("loc","viewBoardFrm.exco?boardNo="+boardNo+"&commentChk=1");
    	}
    	return "common/msg";
    }
    
    @GetMapping(value="updCmtLike.exco", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String, String> chkLikeByComment(String boardNo, String commentNo, String memberNo, int like) {
        String[] result = boardservice.chkLikeByComment(boardNo, commentNo, memberNo, like);
        Map<String, String> response = new HashMap<String, String>();
        
        if (Integer.parseInt(result[0]) > 0) {
            response.put("boardReact", result[2]);
            response.put("message", result[1]);
        } else {
            response.put("boardReact", "0");
            response.put("message", "0");
        }
        return response;
    }
    
    @GetMapping(value="updBoardLike.exco", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String, String> chkLikeByBoard(String boardNo, String commentNo, String memberNo, int like) {
        String[] result = boardservice.chkLikeByBoard(boardNo, memberNo, like);
        Map<String, String> response = new HashMap<String, String>();
        
        if (Integer.parseInt(result[0]) > 0) {
            response.put("cmtReact", result[2]);
            response.put("message", result[1]);
        } else {
            response.put("cmtReact", "0");
            response.put("message", "0");
        }
        return response;
    }
    
    @GetMapping(value = "getCmtStatus.exco", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String, Object> getCmtStatus(String boardNo, String commentNo, String memberNo) {
        // 댓글 상태를 가져오는 서비스 호출
        String cmtReact = boardservice.getCommentReaction(boardNo, commentNo, memberNo);
        System.out.println("cmtReact 넘어온 값:"+ cmtReact);
        Map<String, Object> response = new HashMap<>();
        if (cmtReact != null) {
            response.put("cmtReact", cmtReact); // 현재 상태 반환 (1, -1, 0 등)
            response.put("status", "success");
        } else {
            response.put("cmtReact", "0"); // 기본 상태
            response.put("status", "error");
            response.put("message", "댓글 상태를 가져오는 데 실패했습니다.");
        }
        return response;
    }
    
    @GetMapping(value = "getBoardStatus.exco", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String, Object> getBoardStatus(String boardNo, String memberNo) {
        // 댓글 상태를 가져오는 서비스 호출
        String boardReact = boardservice.getBoardReaction(boardNo, memberNo);
        System.out.println("boardReact 넘어온 값:"+ boardReact);
        Map<String, Object> response = new HashMap<>();
        if (boardReact != null) {
            response.put("boardReact", boardReact); // 현재 상태 반환 (1, -1, 0 등)
            response.put("status", "success");
        } else {
            response.put("boardReact", "0"); // 기본 상태
            response.put("status", "error");
            response.put("message", "댓글 상태를 가져오는 데 실패했습니다.");
        }
        return response;
    }
    
    //관리자페이지 - 커뮤니티 관리(게시판 구별 없이 게시글 전부 불러오기)
  	@GetMapping("adminManageCommunity.exco")
  	public String getManageListAdminPage(Integer reqPage, String searchName, Integer boardType, Model model) {		
  		
  	    // BoardPageData 호출
  	    BoardPageData pd = null;
  	    
  	    if(searchName.equals("board")) {
  	    	pd = boardservice.selectAllBoardList(reqPage, searchName);
		} else if(searchName.equals("null")){ 
			pd = boardservice.selectAllBoardList(reqPage, searchName);
		} else {
  	    	pd = boardservice.selectAllBoardList(reqPage, searchName);
  	    }

  	    // Model에 데이터 추가
  	    model.addAttribute("boardList", pd.getList());
  	   // model.addAttribute("boardTypeNm", boardTypeNm); // 숫자로 변환된 값을 사용
  	    model.addAttribute("pageNavi", pd.getPageNavi());
  		model.addAttribute("boardType", boardType);
  		model.addAttribute("searchName", searchName);
  		
  		//System.out.println(pd.getList());
  		
  	    return "admin/communityManage";
  	}
  	
  	//관리자페이지 - 커뮤니티관리(모든 댓글 불러오기)
  	@GetMapping("adminManageComment.exco")
  	public String getManageCommentList(Integer reqPage, String searchName, Model model) {
  		
  		CommentPageData pd = null;
  		if(searchName.equals("comment")) {
  			pd = boardservice.selectAllCommentList(reqPage, searchName);
		} else if(searchName.equals("null")) {
			pd = boardservice.selectAllCommentList(reqPage, searchName);
		} else {
  			pd = boardservice.selectAllCommentList(reqPage, searchName);
  		}
  		  		
  		model.addAttribute("commentList", pd.getList());
  		model.addAttribute("pageNavi", pd.getPageNavi());
  		model.addAttribute("searchName", searchName);
  		
  		System.out.println("commentList 2 : " +pd.getList());
  		System.out.println("boardController commentListSize : " + pd.getList().size());
  		
  		return "admin/communityManage";
  	}
  	
  	//관리자페이지 - 커뮤니티 관리, 게시글 삭제
  	@GetMapping("adminDeleteBoard.exco")
	public String adminDeleteBoardByBoardNo(String boardNo, int boardType, String searchName, Board board, HttpServletRequest request, Model model) {
		ArrayList<BoardFile> fileList = boardservice.deleteBoardByBoardNo(boardNo);
		
		if (fileList != null && fileList.size() > 0) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");

			for (BoardFile file : fileList) {
				File delFile = new File(savePath + file.getFilePath());

				if (delFile.exists()) {
					delFile.delete();
				}
			}
		}
		model.addAttribute("title", "성공");
		model.addAttribute("msg", "게시글 삭제가 완료되었습니다.");
		model.addAttribute("icon", "success");
		model.addAttribute("loc", "adminManageCommunity.exco?reqPage=1&boardType="+boardType+"&searchName="+searchName);

		// 알림 전송
		String notificationMessage = board.getBoardTitle() +"가 관리자에 의해 삭제되었습니다.";
		emitter.sendEvent(board.getMemberNo(), notificationMessage);	//게시글 작성자에게만 알림 전송
		
		return "common/msg";
		//return "redirect:/board/adminManageList.exco?reqPage=1&boardType="+boardType+"&searchName=" + searchName;
	}
  	
  	//관리자페이지 - 커뮤니티 관리, 댓글 삭제
  	@GetMapping("adminDeleteComment.exco")
    public String adminDeleteComment(String commentNo, String boardNo, Board board, Model model) {
    	int result = boardservice.deleteCommentByCommentNo(commentNo);
    	if(result > 0) {
    		model.addAttribute("title", "성공");
    		model.addAttribute("msg", "댓글 삭제를 완료했습니다.");
    		model.addAttribute("icon", "success");
    		model.addAttribute("loc", "adminManageComment.exco?reqPage=1&searchName=comment");
    		
    		// 알림 전송
    		String notificationMessage = board.getBoardTypeNm() +"에 작성한 댓글이 관리자에 의해 삭제되었습니다.";
    		emitter.sendEvent(board.getMemberNo(), notificationMessage); //댓글 작성자에게만 알림 전송
    	}else {
    		model.addAttribute("title", "오류");
    		model.addAttribute("msg", "댓글 삭제에 실패했습니다.");
    		model.addAttribute("icon", "error");
    		model.addAttribute("loc", "adminManageComment.exco?reqPage=1&searchName=comment");    		
    	}
		return "common/msg";
    }
  	
}