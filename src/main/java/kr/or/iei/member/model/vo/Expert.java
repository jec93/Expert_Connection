package kr.or.iei.member.model.vo;

public class Expert {
	
	private String memberNo;			//회원번호
	private String memberId;			//회원아이디
	private String memberPw;
	private String memberNickname;		//회원 닉네임
	private String memberPhone;			//회원 전화번호
	private String memberAddr;			//회원 주소 
	private String memberGender;		//회원 성별
	private String memberEmail;			//회원 이메일
	private String memberType;			//회원 분류 4, 5, 6 승인 완료 전문가   7, 8, 9 승인 예정 전문가
	private String enrollDate;			//가입일
	
	private String receiveNo;			//승인번호
	private String profilePath;			//프로필 사진 경로
	private String profileName;			//프로필 사진 이름
	private String expertFileName;		//포트폴리오 파일 이름
	private String expertFilePath;		//포트폴리오 파일 경로
	private String permissionState;		//승인 상태 E 예정, P 승인, D 거부, H 정지
	
	private String expertGrade;			//전문가 등급 : 새싹 능숙 노련
	private String thirdCategoryCd;		//서비스 소분류 코드
	private String thirdCategoryNm;		//서비스 소분류 설명
	
	public Expert() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Expert(String memberNo, String memberId, String memberPw, String memberNickname, String memberPhone, String memberAddr,
			String memberGender, String memberEmail, String memberType, String enrollDate, String receiveNo,
			String profilePath, String profileName, String expertFileName, String expertFilePath,
			String permissionState, String expertGrade, String thirdCategoryCd, String thirdCategoryNm) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberNickname = memberNickname;
		this.memberPhone = memberPhone;
		this.memberAddr = memberAddr;
		this.memberGender = memberGender;
		this.memberEmail = memberEmail;
		this.memberType = memberType;
		this.enrollDate = enrollDate;
		this.receiveNo = receiveNo;
		this.profilePath = profilePath;
		this.profileName = profileName;
		this.expertFileName = expertFileName;
		this.expertFilePath = expertFilePath;
		this.permissionState = permissionState;
		this.expertGrade = expertGrade;
		this.thirdCategoryCd = thirdCategoryCd;
		this.thirdCategoryNm = thirdCategoryNm;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberAddr() {
		return memberAddr;
	}

	public void setMemberAddr(String memberAddr) {
		this.memberAddr = memberAddr;
	}

	public String getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
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

	public String getReceiveNo() {
		return receiveNo;
	}

	public void setReceiveNo(String receiveNo) {
		this.receiveNo = receiveNo;
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

	public String getPermissionState() {
		return permissionState;
	}

	public void setPermissionState(String permissionState) {
		this.permissionState = permissionState;
	}

	public String getExpertGrade() {
		return expertGrade;
	}

	public void setExpertGrade(String expertGrade) {
		this.expertGrade = expertGrade;
	}

	public String getThirdCategoryCd() {
		return thirdCategoryCd;
	}

	public void setThirdCategoryCd(String thirdCategoryCd) {
		this.thirdCategoryCd = thirdCategoryCd;
	}

	public String getThirdCategoryNm() {
		return thirdCategoryNm;
	}

	public void setThirdCategoryNm(String thirdCategoryNm) {
		this.thirdCategoryNm = thirdCategoryNm;
	}

	@Override
	public String toString() {
		return "Expert [memberNo=" + memberNo + ", memberId=" + memberId + ", memberNickname=" + memberNickname
				+ ", memberPhone=" + memberPhone + ", memberAddr=" + memberAddr + ", memberGender=" + memberGender
				+ ", memberEmail=" + memberEmail + ", memberType=" + memberType + ", enrollDate=" + enrollDate
				+ ", receiveNo=" + receiveNo + ", profilePath=" + profilePath + ", profileName=" + profileName
				+ ", expertFileName=" + expertFileName + ", expertFilePath=" + expertFilePath + ", permissionState="
				+ permissionState + ", expertGrade=" + expertGrade + ", thirdCategoryCd=" + thirdCategoryCd
				+ ", thirdCategoryNm=" + thirdCategoryNm + "]";
	}
	
}
