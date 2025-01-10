package kr.or.iei.common.emitter.model.vo;

public class Notice {
	private String noticeNo;	//알림번호
	private String memberNo; 	//사용자번호
	private String readYN;		//읽음여부
	private String message;		//알림내용
	private String createdAt;	//알림생성날짜와 시간저장
	private String url;			//알림 클릭시 이동할 수 있는 url
	public Notice() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Notice(String noticeNo, String memberNo, String readYN, String message, String createdAt, String url) {
		super();
		this.noticeNo = noticeNo;
		this.memberNo = memberNo;
		this.readYN = readYN;
		this.message = message;
		this.createdAt = createdAt;
		this.url = url;
	}
	
	public String getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getReadYN() {
		return readYN;
	}
	public void setReadYN(String readYN) {
		this.readYN = readYN;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", memberNo=" + memberNo + ", readYN=" + readYN + ", message=" + message
				+ ", createdAt=" + createdAt + ", url=" + url + "]";
	}
}
