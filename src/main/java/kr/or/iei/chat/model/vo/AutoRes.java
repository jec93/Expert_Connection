package kr.or.iei.chat.model.vo;

public class AutoRes {

	private String responseNo;
    private String memberNo;
    private String triggerWord;
    private String responseContent;
    private String responseDate;
    private String isActive;
    
    //조인
    private String expertNickname;
    private String expertMemberNo;
    
	public AutoRes() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AutoRes(String responseNo, String memberNo, String triggerWord, String responseContent, String responseDate,
			String isActive, String expertNickname, String expertMemberNo) {
		super();
		this.responseNo = responseNo;
		this.memberNo = memberNo;
		this.triggerWord = triggerWord;
		this.responseContent = responseContent;
		this.responseDate = responseDate;
		this.isActive = isActive;
		this.expertNickname = expertNickname;
		this.expertMemberNo = expertMemberNo;
	}

	public String getResponseNo() {
		return responseNo;
	}

	public void setResponseNo(String responseNo) {
		this.responseNo = responseNo;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public String getTriggerWord() {
		return triggerWord;
	}

	public void setTriggerWord(String triggerWord) {
		this.triggerWord = triggerWord;
	}

	public String getResponseContent() {
		return responseContent;
	}

	public void setResponseContent(String responseContent) {
		this.responseContent = responseContent;
	}

	public String getResponseDate() {
		return responseDate;
	}

	public void setResponseDate(String responseDate) {
		this.responseDate = responseDate;
	}

	public String getIsActive() {
		return isActive;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}

	public String getExpertNickname() {
		return expertNickname;
	}

	public void setExpertNickname(String expertNickname) {
		this.expertNickname = expertNickname;
	}

	public String getExpertMemberNo() {
		return expertMemberNo;
	}

	public void setExpertMemberNo(String expertMemberNo) {
		this.expertMemberNo = expertMemberNo;
	}
    
	
}
