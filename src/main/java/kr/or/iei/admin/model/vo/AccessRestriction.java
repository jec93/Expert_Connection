package kr.or.iei.admin.model.vo;

public class AccessRestriction {
	private String reportNo;		//신고번호
	private String memberNo;		//회원번호
	private String restStartDate;	//접근제한시작
	private String restEndDate;		//접근제한종료
	
	public AccessRestriction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AccessRestriction(String reportNo, String memberNo, String restStartDate, String restEndDate) {
		super();
		this.reportNo = reportNo;
		this.memberNo = memberNo;
		this.restStartDate = restStartDate;
		this.restEndDate = restEndDate;
	}

	public String getReportNo() {
		return reportNo;
	}
	public void setReportNo(String reportNo) {
		this.reportNo = reportNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getRestStartDate() {
		return restStartDate;
	}
	public void setRestStartDate(String restStartDate) {
		this.restStartDate = restStartDate;
	}
	public String getRestEndDate() {
		return restEndDate;
	}
	public void setRestEndDate(String restEndDate) {
		this.restEndDate = restEndDate;
	}

	@Override
	public String toString() {
		return "AccessRestriction [reportNo=" + reportNo + ", memberNo=" + memberNo + ", restStartDate=" + restStartDate
				+ ", restEndDate=" + restEndDate + "]";
	}

}
