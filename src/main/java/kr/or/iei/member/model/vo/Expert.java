package kr.or.iei.member.model.vo;

public class Expert {
	
	private String memberNo;
	private String expertId;
	private String expertPw;
	private String expertNickname;
	private String expertPhone;
	private String expertAddr;
	private String expertGender;
	private String expertEmail;
	private String memberType;
	private String enrollDate;
	private String thirdCategoryCd;
	private String expertGrade;

	public Expert() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Expert(String memberNo, String expertId, String expertPw, String expertNickname, String expertPhone,
			String expertAddr, String expertGender, String expertEmail, String memberType, String enrollDate,
			String thirdCategoryCd, String expertGrade) {
		super();
		this.memberNo = memberNo;
		this.expertId = expertId;
		this.expertPw = expertPw;
		this.expertNickname = expertNickname;
		this.expertPhone = expertPhone;
		this.expertAddr = expertAddr;
		this.expertGender = expertGender;
		this.expertEmail = expertEmail;
		this.memberType = memberType;
		this.enrollDate = enrollDate;
		this.thirdCategoryCd = thirdCategoryCd;
		this.expertGrade = expertGrade;
	}

	public String getExpertGrade() {
		return expertGrade;
	}

	public void setExpertGrade(String expertGrade) {
		this.expertGrade = expertGrade;
	}

	public String getThirdCategory() {
		return thirdCategoryCd;
	}

	public void setThirdCategory(String thirdCategoryCd) {
		this.thirdCategoryCd = thirdCategoryCd;
	}

	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getExpertId() {
		return expertId;
	}
	public void setExpertId(String expertId) {
		this.expertId = expertId;
	}
	public String getExpertPw() {
		return expertPw;
	}
	public void setExpertPw(String expertPw) {
		this.expertPw = expertPw;
	}
	public String getExpertNickname() {
		return expertNickname;
	}
	public void setExpertNickname(String expertNickname) {
		this.expertNickname = expertNickname;
	}
	public String getExpertPhone() {
		return expertPhone;
	}
	public void setExpertPhone(String expertPhone) {
		this.expertPhone = expertPhone;
	}
	public String getExpertAddr() {
		return expertAddr;
	}
	public void setExpertAddr(String expertAddr) {
		this.expertAddr = expertAddr;
	}
	public String getExpertGender() {
		return expertGender;
	}
	public void setExpertGender(String expertGender) {
		this.expertGender = expertGender;
	}
	public String getExpertEmail() {
		return expertEmail;
	}
	public void setExpertEmail(String expertEmail) {
		this.expertEmail = expertEmail;
	}
	public String getMemberType() {
		return memberType;
	}
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	public String getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(String enrollDate) {
		this.enrollDate = enrollDate;
	}
	
	@Override
	public String toString() {
		return "Expert [memberNo=" + memberNo + ", expertId=" + expertId + ", expertPw=" + expertPw
				+ ", expertNickname=" + expertNickname + ", expertPhone=" + expertPhone + ", expertAddr=" + expertAddr
				+ ", expertGender=" + expertGender + ", expertEmail=" + expertEmail + ", memberType=" + memberType
				+ ", enrollDate=" + enrollDate + "]";
	}
	

}
