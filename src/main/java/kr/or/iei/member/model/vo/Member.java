package kr.or.iei.member.model.vo;

import java.io.File;
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
	private String profileImage;
	
	private int reportCount;		//신고 횟수
	private int suspectCount;		//신고받은 횟수
	private int restrictionCount;	//접근제한 횟수
	
	private ArrayList<Member> memberList;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String memberNo, String memberId, String memberPw, String memberNickname, String memberPhone,
			String memberAddr, String memberGender, String memberEmail, String memberType, String enrollDate,
			String profileImage, int reportCount, int suspectCount, int restrictionCount,
			ArrayList<Member> memberList) {
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
		this.profileImage = profileImage;
		this.reportCount = reportCount;
		this.suspectCount = suspectCount;
		this.restrictionCount = restrictionCount;
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
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public int getReportCount() {
		return reportCount;
	}
	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	public int getSuspectCount() {
		return suspectCount;
	}
	public void setSuspectCount(int suspectCount) {
		this.suspectCount = suspectCount;
	}
	public int getRestrictionCount() {
		return restrictionCount;
	}
	public void setRestrictionCount(int restrictionCount) {
		this.restrictionCount = restrictionCount;
	}
	public ArrayList<Member> getMemberList() {
		return memberList;
	}
	public void setMemberList(ArrayList<Member> memberList) {
		this.memberList = memberList;
	}
	
	
}