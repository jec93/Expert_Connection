package kr.or.iei.chat.model.vo;

public class Chat {
	
	private String roomId;
	private String roomName;
	private String chatId;
	private String memberNo;
	private String msgGb;
	private String msg;
	private String fileName;
	private String filePath;
	private String msgDate;
	
	//조인
	private String memberNickname;
	private String profilePath;
	private String profileName;
	private String memberType;
	
	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Chat(String roomId, String roomName, String chatId, String memberNo, String msgGb, String msg,
			String fileName, String filePath, String msgDate, String memberNickname, String profilePath,
			String profileName, String memberType) {
		super();
		this.roomId = roomId;
		this.roomName = roomName;
		this.chatId = chatId;
		this.memberNo = memberNo;
		this.msgGb = msgGb;
		this.msg = msg;
		this.fileName = fileName;
		this.filePath = filePath;
		this.msgDate = msgDate;
		this.memberNickname = memberNickname;
		this.profilePath = profilePath;
		this.profileName = profileName;
		this.memberType = memberType;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getChatId() {
		return chatId;
	}

	public void setChatId(String chatId) {
		this.chatId = chatId;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public String getMsgGb() {
		return msgGb;
	}

	public void setMsgGb(String msgGb) {
		this.msgGb = msgGb;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getMsgDate() {
		return msgDate;
	}

	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
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

	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	
}