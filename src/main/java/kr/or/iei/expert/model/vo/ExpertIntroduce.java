package kr.or.iei.expert.model.vo;

public class ExpertIntroduce {
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
	private String expertFile_name;
	private String expertFilePath;
	private String introduceTitle;
	private String introduceContent;
	private String expertLike;
	private String expertDislike;
	private String thirdCategoryNm;
	private String profilePath;
	private String profileName;
	
	public ExpertIntroduce() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ExpertIntroduce(String memberNo, String expertId, String expertPw, String expertNickname, String expertPhone,
			String expertAddr, String expertGender, String expertEmail, String memberType, String enrollDate,
			String thirdCategoryCd, String expertGrade, String expertFile_name, String expertFilePath,
			String introduceTitle, String introduceContent, String expertLike, String expertDislike,
			String thirdCategoryNm, String profilePath, String profileName) {
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
		this.expertFile_name = expertFile_name;
		this.expertFilePath = expertFilePath;
		this.introduceTitle = introduceTitle;
		this.introduceContent = introduceContent;
		this.expertLike = expertLike;
		this.expertDislike = expertDislike;
		this.thirdCategoryNm = thirdCategoryNm;
		this.profilePath = profilePath;
		this.profileName = profileName;
	}

	public String getProfilePath() {
		return profilePath;
	}

	public void setProfilePath(String profilePath) {
		this.profilePath = profilePath;
	}

	public String getProfileName() {
		return profileName;
	}

	public void setProfileName(String profileName) {
		this.profileName = profileName;
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

	public String getThirdCategoryCd() {
		return thirdCategoryCd;
	}

	public void setThirdCategoryCd(String thirdCategoryCd) {
		this.thirdCategoryCd = thirdCategoryCd;
	}

	public String getExpertGrade() {
		return expertGrade;
	}

	public void setExpertGrade(String expertGrade) {
		this.expertGrade = expertGrade;
	}

	public String getExpertFile_name() {
		return expertFile_name;
	}

	public void setExpertFile_name(String expertFile_name) {
		this.expertFile_name = expertFile_name;
	}

	public String getExpertFilePath() {
		return expertFilePath;
	}

	public void setExpertFilePath(String expertFilePath) {
		this.expertFilePath = expertFilePath;
	}

	public String getIntroduceTitle() {
		return introduceTitle;
	}

	public void setIntroduceTitle(String introduceTitle) {
		this.introduceTitle = introduceTitle;
	}

	public String getIntroduceContent() {
		return introduceContent;
	}

	public void setIntroduceContent(String introduceContent) {
		this.introduceContent = introduceContent;
	}

	public String getExpertLike() {
		return expertLike;
	}

	public void setExpertLike(String expertLike) {
		this.expertLike = expertLike;
	}

	public String getExpertDislike() {
		return expertDislike;
	}

	public void setExpertDislike(String expertDislike) {
		this.expertDislike = expertDislike;
	}

	public String getThirdCategoryNm() {
		return thirdCategoryNm;
	}

	public void setThirdCategoryNm(String thirdCategoryNm) {
		this.thirdCategoryNm = thirdCategoryNm;
	}

	@Override
	public String toString() {
		return "ExpertIntroduce [memberNo=" + memberNo + ", expertId=" + expertId + ", expertPw=" + expertPw
				+ ", expertNickname=" + expertNickname + ", expertPhone=" + expertPhone + ", expertAddr=" + expertAddr
				+ ", expertGender=" + expertGender + ", expertEmail=" + expertEmail + ", memberType=" + memberType
				+ ", enrollDate=" + enrollDate + ", thirdCategoryCd=" + thirdCategoryCd + ", expertGrade=" + expertGrade
				+ ", expertFile_name=" + expertFile_name + ", expertFilePath=" + expertFilePath + ", introduceTitle="
				+ introduceTitle + ", introduceContent=" + introduceContent + ", expertLike=" + expertLike
				+ ", expertDislike=" + expertDislike + ", thirdCategoryNm=" + thirdCategoryNm + ", profilePath="
				+ profilePath + ", profileName=" + profileName + "]";
	}
	
	
}