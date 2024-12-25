package kr.or.iei.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.board.model.vo.Board;
import kr.or.iei.board.model.vo.BoardComment;
import kr.or.iei.board.model.vo.BoardFile;

@Repository("boardDao")
public class BoardDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	//게시글 조회
	public List<Board> selectboardList(HashMap<String, Integer> map) {
		return sqlSession.selectList("board.selectBoardList", map);
	}

	//전체 게시글 갯수 조회
	public int selectboardCount(int boardType) {
		return sqlSession.selectOne("board.selectBoardCount",boardType);
	}

	public String createBoardNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.createBoardNo");
	}

	public int insertBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertBoard",board);
	}

	public Board viewByBoardNo(String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.viewByBoardNo",boardNo);
	}

	public int updateReadByboardNo(String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updateReadByboardNo",boardNo);
	}

	public List<BoardFile> ReadFileByBoardNo(String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.readFileByBoardNo",boardNo);
	}

	public List<BoardComment> readCommentListByBoardNo(String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.readCommentListByBoardNo",boardNo);
	}

	public int insertBoardFileByFile(BoardFile file) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertBoardFileByFile",file);
	}

	public int deleteBoardByBoardNo(String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteBoardByBoardNo",boardNo);
	}

	public int updateBoardByNewBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updateBoardByNewBoard",board);
	}

	public int deleteBoardFileByBoardNo(String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteBoardFileByBoardNo", boardNo);
	}

}