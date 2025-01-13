package kr.or.iei.member.model.vo;

import java.util.ArrayList;

public class Member {
	
	private String memberNo;
	private String memberId;
	private String memberPw;
	private String memberNickname;
	private String memberPhone;
	private String memberAddr;
	private String memberGender;
	private String memberEmail;
	private String memberType;
	private String enrollDate;
	private String profilePath;
	private String profileName;
	
	
	
	private String loginChkYn;        //로그인 가능 여부
    
	private ArrayList<Member> memberList;

	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String memberNo, String memberId, String memberPw, String memberNickname, String memberPhone,
			String memberAddr, String memberGender, String memberEmail, String memberType, String enrollDate,
			String profilePath, String profileName, String loginChkYn, ArrayList<Member> memberList) {
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
		this.profilePath = profilePath;
		this.profileName = profileName;
		this.loginChkYn = loginChkYn;
		this.memberList = memberList;
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

	public String getLoginChkYn() {
		return loginChkYn;
	}

	public void setLoginChkYn(String loginChkYn) {
		this.loginChkYn = loginChkYn;
	}

	public ArrayList<Member> getMemberList() {
		return memberList;
	}

	public void setMemberList(ArrayList<Member> memberList) {
		this.memberList = memberList;
	}

	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPw=" + memberPw
				+ ", memberNickname=" + memberNickname + ", memberPhone=" + memberPhone + ", memberAddr=" + memberAddr
				+ ", memberGender=" + memberGender + ", memberEmail=" + memberEmail + ", memberType=" + memberType
				+ ", enrollDate=" + enrollDate + ", profilePath=" + profilePath + ", profileName=" + profileName
				+ ", loginChkYn=" + loginChkYn + ", memberList=" + memberList + "]";
	}
	
	
}