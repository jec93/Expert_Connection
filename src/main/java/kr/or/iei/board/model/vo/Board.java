package kr.or.iei.board.model.vo;

import java.util.ArrayList;

import kr.or.iei.member.model.vo.Member;

public class Board {
	private String boardNo;			//게시글 번호
	private String memberNo;
	private String boardWriter;		//게시글 작성자
	private int boardType;			//게시판 분류 : 0, 1, 2, 3, 4, 5, 6
	private String boardTypeNm;		//게시판 분류 이름 : "사용자 게시판", "전문가 게시판", "전문가 노하우", "그룹레슨", "공지사항", "FAQ", "1:1문의"
	private String boardTitle;		//게시글 제목
	private String boardContent;	//게시글 내용
	private String boardDate;		//작성일
	private String boardCount;		//조회수
	private int boardLike;			//게시글 좋아요
	private int boardDislike;		//게시글 아쉬워요
	
	private int report;				//게시글 신고
	private Member member;
	
	private ArrayList<BoardFile> fileList; //게시글 파일 리스트
	private ArrayList<BoardComment> commentList;
	
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Board(String boardNo, String memberNo, String boardWriter, int boardType, String boardTypeNm,
			String boardTitle, String boardContent, String boardDate, String boardCount, int boardLike,
			int boardDislike, int report, Member member, ArrayList<BoardFile> fileList,
			ArrayList<BoardComment> commentList) {
		super();
		this.boardNo = boardNo;
		this.memberNo = memberNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTypeNm = boardTypeNm;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardDate = boardDate;
		this.boardCount = boardCount;
		this.boardLike = boardLike;
		this.boardDislike = boardDislike;
		this.report = report;
		this.member = member;
		this.fileList = fileList;
		this.commentList = commentList;
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
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public int getBoardType() {
		return boardType;
	}
	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}
	public String getBoardTypeNm() {
		return boardTypeNm;
	}
	public void setBoardTypeNm(String boardTypeNm) {
		this.boardTypeNm = boardTypeNm;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}
	public String getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(String boardCount) {
		this.boardCount = boardCount;
	}
	public int getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}
	public int getBoardDislike() {
		return boardDislike;
	}
	public void setBoardDislike(int boardDislike) {
		this.boardDislike = boardDislike;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public ArrayList<BoardFile> getFileList() {
		return fileList;
	}
	public void setFileList(ArrayList<BoardFile> fileList) {
		this.fileList = fileList;
	}
	public ArrayList<BoardComment> getCommentList() {
		return commentList;
	}
	public void setCommentList(ArrayList<BoardComment> commentList) {
		this.commentList = commentList;
	}
	
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", memberNo=" + memberNo + ", boardWriter=" + boardWriter + ", boardType="
				+ boardType + ", boardTypeNm=" + boardTypeNm + ", boardTitle=" + boardTitle + ", boardContent="
				+ boardContent + ", boardDate=" + boardDate + ", boardCount=" + boardCount + ", boardLike=" + boardLike
				+ ", boardDislike=" + boardDislike + ", report=" + report + ", member=" + member + ", fileList="
				+ fileList + ", commentList=" + commentList + "]";
	}
}
