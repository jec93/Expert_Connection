package kr.or.iei.board.model.vo;

import java.util.ArrayList;

public class CommentPageData {
	private ArrayList<BoardComment> list;
	private String pageNavi;
	
	public CommentPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CommentPageData(ArrayList<BoardComment> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	
	public ArrayList<BoardComment> getList() {
		return list;
	}
	public void setList(ArrayList<BoardComment> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	
	@Override
	public String toString() {
		return "CommentPageData [list=" + list + ", pageNavi=" + pageNavi + "]";
	}
}
