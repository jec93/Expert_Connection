package kr.or.iei.board.model.vo;

public class CommentReact {
	private String commentNo; //댓글 번호
	private String memberNo; //유저 번호
	private int commentChk; //댓글 좋아요 여부
	private int report; //신고
	
	public CommentReact() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CommentReact(String commentNo, String memberNo, int commentChk, int report) {
		super();
		this.commentNo = commentNo;
		this.memberNo = memberNo;
		this.commentChk = commentChk;
		this.report = report;
	}
	public String getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public int getCommentChk() {
		return commentChk;
	}
	public void setCommentChk(int commentChk) {
		this.commentChk = commentChk;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
}
