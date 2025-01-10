package kr.or.iei.expert.model.vo;

import java.util.ArrayList;

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
	private String expertFileName;
	private String expertFilePath;
	private String introduceTitle;
	private String introduceContent;
	private String expertLike;
	private String expertDislike;
	private String thirdCategoryNm;
	private String profilePath;
	private String profileName;
	private String introNo;
	
	private ArrayList<Review> reviewList;
	
	public ExpertIntroduce() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ExpertIntroduce(String memberNo, String expertId, String expertPw, String expertNickname, String expertPhone,
			String expertAddr, String expertGender, String expertEmail, String memberType, String enrollDate,
			String thirdCategoryCd, String expertGrade, String expertFileName, String expertFilePath,
			String introduceTitle, String introduceContent, String expertLike, String expertDislike,
			String thirdCategoryNm, String profilePath, String profileName, String introNo,
			ArrayList<Review> reviewList) {
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
		this.expertFileName = expertFileName;
		this.expertFilePath = expertFilePath;
		this.introduceTitle = introduceTitle;
		this.introduceContent = introduceContent;
		this.expertLike = expertLike;
		this.expertDislike = expertDislike;
		this.thirdCategoryNm = thirdCategoryNm;
		this.profilePath = profilePath;
		this.profileName = profileName;
		this.introNo = introNo;
		this.reviewList = reviewList;
	}

	public ArrayList<Review> getReviewList() {
		return reviewList;
	}

	public void setReviewList(ArrayList<Review> reviewList) {
		this.reviewList = reviewList;
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

	public String getExpertFileName() {
		return expertFileName;
	}

	public void setExpertFileName(String expertFileName) {
		this.expertFileName = expertFileName;
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

	@Override
	public String toString() {
		return "ExpertIntroduce [memberNo=" + memberNo + ", expertId=" + expertId + ", expertPw=" + expertPw
				+ ", expertNickname=" + expertNickname + ", expertPhone=" + expertPhone + ", expertAddr=" + expertAddr
				+ ", expertGender=" + expertGender + ", expertEmail=" + expertEmail + ", memberType=" + memberType
				+ ", enrollDate=" + enrollDate + ", thirdCategoryCd=" + thirdCategoryCd + ", expertGrade=" + expertGrade
				+ ", expertFileName=" + expertFileName + ", expertFilePath=" + expertFilePath + ", introduceTitle="
				+ introduceTitle + ", introduceContent=" + introduceContent + ", expertLike=" + expertLike
				+ ", expertDislike=" + expertDislike + ", thirdCategoryNm=" + thirdCategoryNm + ", profilePath="
				+ profilePath + ", profileName=" + profileName + ", introNo=" + introNo + ", reviewList=" + reviewList
				+ "]";
	}
	
}