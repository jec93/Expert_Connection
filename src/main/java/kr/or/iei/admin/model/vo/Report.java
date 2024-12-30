package kr.or.iei.admin.model.vo;

public class Report {
	private String reportNo;		//신고번호
	private int reportType;			//신고 분류 - 0:게시글, 1:댓글
	private String reportDate;		//신고한 날짜
	private String reporter; 		//신고한 회원
	private String suspect;			//신고받은 회원
	private String reportResult;	//신고처리결과
	private String targetNo;		//신고대상 boardNo 또는 commentNo
	private String firstCategoryCd;		// D0001
	private String firstCategoryNM;		//신고코드 관리
	private String secondCategoryCd;	//301_a0001, 301_a0002, 301_a0003, 301_a0004
	private String secondCategoryNM;	//신고코드 종류, 수정, 추가, 삭제
	private String thirdCategoryCd;		//A_301_a0001, A_301_a0002, A_301_a0003, A_301_a0004, A_301_a0005, A_301_a0006, A_301_a0007, A_301_a0008, A_301_a0009, A_301_a0010, B_301_a0001, C_301_a0001, D_301_a0001
	private String thirdCategoryNM;		//신고사유 10개, 신고코드 수정, 추가, 삭제
	
	public Report() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Report(String reportNo, int reportType, String reportDate, String reporter, String suspect,
			String reportResult, String targetNo, String firstCategoryCd, String firstCategoryNM,
			String secondCategoryCd, String secondCategoryNM, String thirdCategoryCd, String thirdCategoryNM) {
		super();
		this.reportNo = reportNo;
		this.reportType = reportType;
		this.reportDate = reportDate;
		this.reporter = reporter;
		this.suspect = suspect;
		this.reportResult = reportResult;
		this.targetNo = targetNo;
		this.firstCategoryCd = firstCategoryCd;
		this.firstCategoryNM = firstCategoryNM;
		this.secondCategoryCd = secondCategoryCd;
		this.secondCategoryNM = secondCategoryNM;
		this.thirdCategoryCd = thirdCategoryCd;
		this.thirdCategoryNM = thirdCategoryNM;
	}

	public String getReportNo() {
		return reportNo;
	}
	public void setReportNo(String reportNo) {
		this.reportNo = reportNo;
	}
	public int getReportType() {
		return reportType;
	}
	public void setReportType(int reportType) {
		this.reportType = reportType;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getSuspect() {
		return suspect;
	}
	public void setSuspect(String suspect) {
		this.suspect = suspect;
	}
	public String getReportResult() {
		return reportResult;
	}
	public void setReportResult(String reportResult) {
		this.reportResult = reportResult;
	}
	public String getTargetNo() {
		return targetNo;
	}
	public void setTargetNo(String targetNo) {
		this.targetNo = targetNo;
	}
	public String getFirstCategoryCd() {
		return firstCategoryCd;
	}
	public void setFirstCategoryCd(String firstCategoryCd) {
		this.firstCategoryCd = firstCategoryCd;
	}
	public String getFirstCategoryNM() {
		return firstCategoryNM;
	}
	public void setFirstCategoryNM(String firstCategoryNM) {
		this.firstCategoryNM = firstCategoryNM;
	}
	public String getSecondCategoryCd() {
		return secondCategoryCd;
	}
	public void setSecondCategoryCd(String secondCategoryCd) {
		this.secondCategoryCd = secondCategoryCd;
	}
	public String getSecondCategoryNM() {
		return secondCategoryNM;
	}
	public void setSecondCategoryNM(String secondCategoryNM) {
		this.secondCategoryNM = secondCategoryNM;
	}
	public String getThirdCategoryCd() {
		return thirdCategoryCd;
	}
	public void setThirdCategoryCd(String thirdCategoryCd) {
		this.thirdCategoryCd = thirdCategoryCd;
	}
	public String getThirdCategoryNM() {
		return thirdCategoryNM;
	}
	public void setThirdCategoryNM(String thirdCategoryNM) {
		this.thirdCategoryNM = thirdCategoryNM;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportType=" + reportType + ", reportDate=" + reportDate
				+ ", reporter=" + reporter + ", suspect=" + suspect + ", reportResult=" + reportResult + ", targetNo="
				+ targetNo + ", firstCategoryCd=" + firstCategoryCd + ", firstCategoryNM=" + firstCategoryNM
				+ ", secondCategoryCd=" + secondCategoryCd + ", secondCategoryNM=" + secondCategoryNM
				+ ", thirdCategoryCd=" + thirdCategoryCd + ", thirdCategoryNM=" + thirdCategoryNM + "]";
	}
	
}
