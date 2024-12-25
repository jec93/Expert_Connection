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
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;

import kr.or.iei.board.model.service.BoardService;
import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardFile;
import kr.or.iei.board.model.vo.BoardPageData;
import kr.or.iei.board.model.vo.BoardType;

@Controller("boardController")
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	@Qualifier("boardService")
	private BoardService boardservice;
	
	//게시글 목록 조회
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
	
	//게시글 작성
	@GetMapping("writeFrm.exco")
	public String getWriteFrm(Integer boardType,String boardTypeNm, Model model){
		if(boardType==null) {
			throw new IllegalArgumentException("게시판 정보를 가져오는중 에러");
		}
		model.addAttribute("boardType",boardType);
		model.addAttribute("boardTypeNm",boardTypeNm);
		return"board/boardWrite";
	}
	
	@PostMapping("write.exco")
	public String insertBoard(HttpServletRequest request, MultipartFile[] files, Board board) {
		if(board.getBoardWriter().trim().isEmpty()) {
			throw new IllegalArgumentException("작성자 이름이 비었습니다.");
		}
		if(board.getBoardTitle().trim().isEmpty()) {
			throw new IllegalArgumentException("게시판 제목이 비었습니다.");
		}
		if(board.getBoardContent().trim().isEmpty()) {
			throw new IllegalArgumentException("게시판 내용이 비었습니다.");
		}
		/*
		 * 널체크할거 더 있음
		 */
		
		ArrayList<BoardFile> fileList = new ArrayList<BoardFile>();
		for(int i=0; i<files.length; i++) {
			MultipartFile file=files[i];
			
			if(!file.isEmpty()) {
				String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");
				String originalFileName = file.getOriginalFilename(); // 사용자가 업로드한 파일명
				
				String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));// 확장자 이전까지
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());// 지금 날짜!!
				
				int ranNum = new Random().nextInt(10000) + 1; //1~10000 숫자중 랜덤
				String filePath = fileName + "_" + toDay + "_" + ranNum + extension; //서버에 올라갈 파일명: 파일이름_날짜_랜덤숫자.확장자
				
				savePath += filePath;
				
				BufferedOutputStream bos=null;
				
				try {
					byte[] bytes = file.getBytes();
					FileOutputStream fos = new FileOutputStream(new File(savePath));
					bos=new BufferedOutputStream(fos);
					bos.write(bytes);
					
					BoardFile boardFile = new BoardFile();
					
					boardFile.setFileName(originalFileName);
					boardFile.setFilePath(filePath);
					
					fileList.add(boardFile);
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					try {
						bos.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		int result = boardservice.insertBoard(board, fileList);
		
		if(result>0) {
			request.setAttribute("title", "성공");
	        request.setAttribute("msg",board.getBoardTypeNm() + "이 작성되었습니다.");
	        request.setAttribute("icon", "success");
	        request.setAttribute("loc", "list.exco?reqPage=1&boardType="+board.getBoardType()+"&boardTypeNm="+board.getBoardType()); //숫자로 받아야 해서 이름(boardTypeNm)이 아닌 코드로 줌
		}
		return "common/msg";
	}
	
	@GetMapping("/viewBoardFrm.exco")
	public String viewFrm(String boardNo,String commentChk, Model model) { //댓글 작성 후 돌아오는 화면에서 조회수를 늘리지 않기 위한 commentChk변수
		Board board = boardservice.viewFrm(boardNo,commentChk);
		if(board==null) {
			return "redirect:/";
		}
		model.addAttribute("board",board);
		System.out.println("board파일리스트 : "+board.getFileList());
		return "board/view";
	}
	
	@GetMapping("/updateFrm.exco")
	public String updateFrm(String boardNo, Model model) {
		//기존 게시글 정보 가져오기(viewFrm)의 경우 접근시 조회수가 증가하므로 다르게 접근
		Board board = boardservice.connectView(boardNo);
		model.addAttribute("board",board);
		return "board/updateFrm";
	}
	
	@PostMapping("/update.exco")
	public String updateBoardByNewBoard(HttpServletRequest request,	MultipartFile[] files,MultipartFile[] addFile, Board board) {
        
        System.out.println("기존파일 길이"+files.length);
        System.out.println("신규파일 길이"+addFile.length);
		
		ArrayList<BoardFile> fileList = new ArrayList<BoardFile>();
		
		//파일 객체와 게시글 고유번호 전달
		for(int i=0;i<files.length; i++) {
			MultipartFile file = files[i];
			
			if(!file.isEmpty()) {
				String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");
				String originalFileName = file.getOriginalFilename();

				String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());

				int rannum = new Random().nextInt(10000) + 1;// 1~10000까지 숫자중 랭덤
				String filePath = fileName + "_" + toDay + "_" + rannum + extension;
				
				savePath += filePath;

				BufferedOutputStream bos = null;
				
				try {
					byte[] bytes = file.getBytes();
					FileOutputStream fos = new FileOutputStream(new File(savePath));
					bos = new BufferedOutputStream(fos);
					bos.write(bytes);
					
					BoardFile boardFile = new BoardFile();
					boardFile.setBoardNo(board.getBoardNo());
					System.out.println(board.getBoardNo()+"boardNo");
					boardFile.setFileName(originalFileName);
					boardFile.setFilePath(filePath);
					fileList.add(boardFile);
					System.out.println("BoardFile 객체 생성: " + boardFile);
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					try {
						bos.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		System.out.println("컨트롤러에서 fileList"+fileList);
		//기존 파일 정보 삭제 후
		ArrayList<BoardFile> delFileList = boardservice.updateBoardByNewBoard(board, fileList);
		if(delFileList !=null && delFileList.size() >0) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");
			
			for(BoardFile file : fileList) {
				File delfile = new File(savePath + file.getFilePath());
				
				if(delfile.exists()) {
					delfile.delete();
				}
			}
		}
		return "redirect:/board/list.exco?reqPage=1&boardType="+board.getBoardType()+"&boardTypeNm="+board.getBoardType();
	}
	
	
	@GetMapping(value = "fileDown.exco", produces = "application/octet-stream;")
	public void boardFileDown(HttpServletRequest request, HttpServletResponse response, String fileName, String filePath) {
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
	public String deleteBoardByBoardNo(String boardNo,int boardType, HttpServletRequest request) {
		ArrayList<BoardFile> fileList = boardservice.deleteBoardByBoardNo(boardNo);
		if(fileList != null && fileList.size() > 0) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/board/");
			
			for(BoardFile file : fileList) {
				File delFile = new File(savePath + file.getFilePath());
				
				if(delFile.exists()) {
					delFile.delete();
				}
			}
		}
		return "redirect:/board/list.exco?reqPage=1&boardType="+boardType+"&boardTypeNm="+boardType;
	}
}