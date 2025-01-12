package kr.or.iei.expert.model.vo;

public class IntroduceReaction {
	private String introNo;
	private String expertNo;
	private String memberNo;
	private int introReact;
	private int report;
	public IntroduceReaction() {
		super();
		// TODO Auto-generated constructor stub
	}
	public IntroduceReaction(String introNo, String expertNo, String memberNo, int introReact, int report) {
		super();
		this.introNo = introNo;
		this.expertNo = expertNo;
		this.memberNo = memberNo;
		this.introReact = introReact;
		this.report = report;
	}
	public String getIntroNo() {
		return introNo;
	}
	public void setIntroNo(String introNo) {
		this.introNo = introNo;
	}
	public String getExpertNo() {
		return expertNo;
	}
	public void setExpertNo(String expertNo) {
		this.expertNo = expertNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public int getIntroReact() {
		return introReact;
	}
	public void setIntroReact(int introReact) {
		this.introReact = introReact;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	@Override
	public String toString() {
		return "ReviewReaction [introNo=" + introNo + ", expertNo=" + expertNo + ", memberNo=" + memberNo
				+ ", introReact=" + introReact + ", report=" + report + "]";
	}
}
