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

	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Chat(String roomId, String roomName, String chatId, String memberNo, String msgGb, String msg,
			String fileName, String filePath, String msgDate, String memberNickname) {
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
	
	
}
