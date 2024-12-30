package kr.or.iei.board.model.vo;

public class BoardReact {
	private String boardNo;
	private String memberNo;
	private int boardReaction;
	private int report;
	public BoardReact() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardReact(String boardNo, String memberNo, int boardReaction, int report) {
		super();
		this.boardNo = boardNo;
		this.memberNo = memberNo;
		this.boardReaction = boardReaction;
		this.report = report;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public int getBoardReaction() {
		return boardReaction;
	}
	public void setBoardReaction(int boardReaction) {
		this.boardReaction = boardReaction;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	
	
}
