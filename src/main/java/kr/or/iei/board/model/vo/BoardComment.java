package kr.or.iei.board.model.vo;

public class BoardComment {
	private String commentNo;
	private String boardNo;
	private String memberNo;
	private String commentWriter;
	private String commentContent;
	private String commentDate;
	private String commentLike;
	private String commentDislike;
	
	private int report;		// 댓글 신고

	public BoardComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BoardComment(String commentNo, String boardNo, String memberNo, String commentWriter, String commentContent,
			String commentDate, String commentLike, String commentDislike, int report) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.memberNo = memberNo;
		this.commentWriter = commentWriter;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		this.commentLike = commentLike;
		this.commentDislike = commentDislike;
		this.report = report;
	}

	public String getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
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
	public String getCommentWriter() {
		return commentWriter;
	}
	public void setCommentWriter(String commentWriter) {
		this.commentWriter = commentWriter;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentLike() {
		return commentLike;
	}
	public void setCommentLike(String commentLike) {
		this.commentLike = commentLike;
	}
	public String getCommentDislike() {
		return commentDislike;
	}
	public void setCommentDislike(String commentDislike) {
		this.commentDislike = commentDislike;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}

	@Override
	public String toString() {
		return "BoardComment [commentNo=" + commentNo + ", boardNo=" + boardNo + ", memberNo=" + memberNo
				+ ", commentWriter=" + commentWriter + ", commentContent=" + commentContent + ", commentDate="
				+ commentDate + ", commentLike=" + commentLike + ", commentDislike=" + commentDislike + ", report="
				+ report + "]";
	}
	
}
