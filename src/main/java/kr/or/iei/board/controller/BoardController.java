package kr.or.iei.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.board.model.service.BoardService;
import kr.or.iei.board.model.vo.Board;
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

	    System.out.println("요청페이지 : " + reqPage);
	    System.out.println("게시판 분류 : " + boardType);
	    System.out.println("게시판 이름 : " + boardTypeNm);

	    // BoardPageData 호출
	    BoardPageData pd = boardservice.selectBoardList(boardType, reqPage, boardTypeNm);

	    // Model에 데이터 추가
	    model.addAttribute("boardList", pd.getList());
	    model.addAttribute("boardTypeNm", BoardType.type[typeName]); // 숫자로 변환된 값을 사용
	    model.addAttribute("pageNavi", pd.getPageNavi());
	    model.addAttribute("boardType", boardType);
	    System.out.println("boardType: " + boardType);

	    return "board/boardList";
	}
}
