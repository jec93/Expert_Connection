package kr.or.iei.expert.model.vo;

public class Review {
	private String reviewNo;
	private String introNo;
	private String memberNo;
	private String writer;
	private String nickname;
	private String reviewContent;
	private String reviewDate;
	private int reviewScore;
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Review(String reviewNo, String introNo, String memberNo, String writer, String nickname,
			String reviewContent, String reviewDate, int reviewScore) {
		super();
		this.reviewNo = reviewNo;
		this.introNo = introNo;
		this.memberNo = memberNo;
		this.writer = writer;
		this.nickname = nickname;
		this.reviewContent = reviewContent;
		this.reviewDate = reviewDate;
		this.reviewScore = reviewScore;
	}

	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(String reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getIntroNo() {
		return introNo;
	}
	public void setIntroNo(String introNo) {
		this.introNo = introNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}

	public int getReviewScore() {
		return reviewScore;
	}

	public void setReviewScore(int reviewScore) {
		this.reviewScore = reviewScore;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", introNo=" + introNo + ", memberNo=" + memberNo + ", writer=" + writer
				+ ", nickname=" + nickname + ", reviewContent=" + reviewContent + ", reviewDate=" + reviewDate
				+ ", reviewScore=" + reviewScore + "]";
	}
}
