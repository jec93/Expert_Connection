package kr.or.iei.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.board.model.vo.Board;

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
	public int selectboardCount() {
		return sqlSession.selectOne("board.selectBoardCount");
	}

}
