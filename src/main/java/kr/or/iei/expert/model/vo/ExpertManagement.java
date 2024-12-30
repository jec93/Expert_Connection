package kr.or.iei.expert.model.vo;

import java.sql.Blob;

public class ExpertManagement {

	 private String receiveNo;       
	    private String memberNo;        
	    private Blob expertFile;       
	    private String permissionState; 
	    private int expertGrade;        
	    private String thirdCategoryCd;
	    
	    //조인
	    private String thirdCategoryNm;
	    private String memberNickname;
	    private String memberAddr;
	    
		public ExpertManagement() {
			super();
			// TODO Auto-generated constructor stub
		}

		public ExpertManagement(String receiveNo, String memberNo, Blob expertFile, String permissionState,
				int expertGrade, String thirdCategoryCd, String thirdCategoryNm, String memberNickname,
				String memberAddr) {
			super();
			this.receiveNo = receiveNo;
			this.memberNo = memberNo;
			this.expertFile = expertFile;
			this.permissionState = permissionState;
			this.expertGrade = expertGrade;
			this.thirdCategoryCd = thirdCategoryCd;
			this.thirdCategoryNm = thirdCategoryNm;
			this.memberNickname = memberNickname;
			this.memberAddr = memberAddr;
		}

		public String getReceiveNo() {
			return receiveNo;
		}

		public void setReceiveNo(String receiveNo) {
			this.receiveNo = receiveNo;
		}

		public String getMemberNo() {
			return memberNo;
		}

		public void setMemberNo(String memberNo) {
			this.memberNo = memberNo;
		}

		public Blob getExpertFile() {
			return expertFile;
		}

		public void setExpertFile(Blob expertFile) {
			this.expertFile = expertFile;
		}

		public String getPermissionState() {
			return permissionState;
		}

		public void setPermissionState(String permissionState) {
			this.permissionState = permissionState;
		}

		public int getExpertGrade() {
			return expertGrade;
		}

		public void setExpertGrade(int expertGrade) {
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

		public String getMemberNickname() {
			return memberNickname;
		}

		public void setMemberNickname(String memberNickname) {
			this.memberNickname = memberNickname;
		}

		public String getMemberAddr() {
			return memberAddr;
		}

		public void setMemberAddr(String memberAddr) {
			this.memberAddr = memberAddr;
		}
		
}