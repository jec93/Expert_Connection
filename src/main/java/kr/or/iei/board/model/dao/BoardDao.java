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
import kr.or.iei.board.model.vo.BoardReact;
import kr.or.iei.board.model.vo.CommentReact;
import kr.or.iei.board.model.vo.MoveStin;

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

	public void deleteFileById(String fileNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("board.deleteBoardFileByFileId",fileNo);
	}

	public int insertCommentByComment(BoardComment comment) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertCommentByComment",comment);
	}

	public int deleteCommentByCommentNo(String commentNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteCommentByCommentNo", commentNo);
	}

	public int updateCommentByComment(BoardComment comment) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updateCommentByComment",comment);
	}

	//관리자페이지 - 게시판 분류 없이 모든 게시글 조회
	public List<Board> selectAllboardList(HashMap<String, Integer> map) {
		return sqlSession.selectList("board.selectAllBoardList", map);
	}
	
	//관리자페이지 - 게시판 분류 없이 모든 게시글 갯수 조회
	public int selectAllBoardCount() {
		return sqlSession.selectOne("board.selectAllBoardCount");
	}

	//관리자페이지 - 모든 댓글 조회
	public List<BoardComment> selectAllCommentList(HashMap<String, Integer> map) {
		return sqlSession.selectList("board.selectAllCommentList", map);
	}
	
	//관리자페이지 - 모든 댓글 갯수 조회
	public int selectAllCommentCount() {
		return sqlSession.selectOne("board.selectAllCommentCount");
	}
	
	public CommentReact chkLikeByComment(HashMap<String, String> infoNumMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.chkLikeByComment",infoNumMap);
	}

	public int updateComLikeCnt(MoveStin moveData) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updateComLikeCnt",moveData);
	}

	public int insertComLikeInfo(CommentReact ractInfo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertComLikeInfo",ractInfo);
	}

	public void updateCommentLikeByComment(HashMap<String, Object> commentParamMap) {
		// TODO Auto-generated method stub
	    sqlSession.update("board.updateCommentLikeByComment", commentParamMap);
	}

	public int insertBoardLikeInfo(BoardReact reactInfo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertBoardLikeInfo",reactInfo);
	}

	public void updateBoardLikeByBoard(HashMap<String, Object> boardParamMap) {
		// TODO Auto-generated method stub
		sqlSession.update("board.updateBoardLikeByBoard", boardParamMap);
	}

	public int updBoardByReact(BoardReact boardReact) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updBoardByReact",boardReact);
	}

	public BoardReact chkBoardLikeByBoard(HashMap<String, String> infoNumMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.chkBoardLikeByBoard",infoNumMap);
	}

	public BoardComment commentBycommentNo(String commentNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.commentBycommentNo",commentNo);
	}

	public int updReactByReact(CommentReact commentReact) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updReactByReact",commentReact);
	}

	//댓글번호로 댓글이 작성된 게시글 번호 조회
	public String searchBoardNoByCommentNo(String commentNo) {
		return sqlSession.selectOne("board.searchBoardNoByCommentNo", commentNo);
	}
}