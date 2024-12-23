package kr.or.iei.board.model.vo;

public class BoardComment {
	private String commentNo;
	private String boardNo;
	private String commentWriter;
	private String commentContent;
	private String commentDate;
	private String commentLike;
	private String commentDislike;
	public BoardComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardComment(String commentNo, String boardNo, String commentWriter, String commentContent,
			String commentDate, String commentLike, String commentDislike) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.commentWriter = commentWriter;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		this.commentLike = commentLike;
		this.commentDislike = commentDislike;
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
	
}
