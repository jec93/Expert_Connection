package kr.or.iei.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.board.model.service.BoardService;
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
	public String getList(int reqPage, int boardType, String boardTypeNm, Model model) {
		
		int typeName = Integer.parseInt(boardTypeNm);
		
		System.out.println("요청페이지 : " + reqPage);
		System.out.println("게시판 분류 : " + boardType);
		System.out.println("게시판 이름 : " + boardTypeNm);
		
		BoardPageData pd = boardservice.selectBoardList(boardType, reqPage, boardTypeNm);
		
		//응답 페이지(게시판분류+list.jsp)에서 게시글 목록을 보여주기 위해, 응답 데이터를 등록할 수 있는 Model 객체 매개변수에 추가
		model.addAttribute("list", pd.getList());
		model.addAttribute("boardTypeNm", BoardType.type[typeName]);
		model.addAttribute("pageNavi", pd.getPageNavi());
		model.addAttribute("boardType", boardType);
		return "board/boardList";
	}
}
