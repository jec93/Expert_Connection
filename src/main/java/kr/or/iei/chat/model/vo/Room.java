package kr.or.iei.chat.model.vo;

public class Room {
    private String roomId;
    private String roomName;
    private String createNo;
    private String msgDate;
    private boolean isHidden; //숨김 상태 추가

    // 조인
    private String msg;
    private String memberNickname;

    // 추가된 필드
    private String displayName; // 화면에 표시될 이름 (채팅방 이름 or 상대방 닉네임)
    private int memberCount;    // 채팅방 참여자 수
    
	public Room() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Room(String roomId, String roomName, String createNo, String msgDate, boolean isHidden, String msg,
			String memberNickname, String displayName, int memberCount) {
		super();
		this.roomId = roomId;
		this.roomName = roomName;
		this.createNo = createNo;
		this.msgDate = msgDate;
		this.isHidden = isHidden;
		this.msg = msg;
		this.memberNickname = memberNickname;
		this.displayName = displayName;
		this.memberCount = memberCount;
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
	public String getCreateNo() {
		return createNo;
	}
	public void setCreateNo(String createNo) {
		this.createNo = createNo;
	}
	public String getMsgDate() {
		return msgDate;
	}
	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}
	public boolean isHidden() {
		return isHidden;
	}
	public void setHidden(boolean isHidden) {
		this.isHidden = isHidden;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public int getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}
}
