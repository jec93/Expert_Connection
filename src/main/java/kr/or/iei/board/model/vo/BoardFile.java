package kr.or.iei.board.model.vo;

public class BoardFile {
	private String fileNo;
	private String boardNo;
	private String fileName;
	private String filePath;
	public BoardFile() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardFile(String fileNo, String boardNo, String fileName, String filePath) {
		super();
		this.fileNo = fileNo;
		this.boardNo = boardNo;
		this.fileName = fileName;
		this.filePath = filePath;
	}
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
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
	@Override
	public String toString() {
		return "BoardFile [fileNo=" + fileNo + ", boardNo=" + boardNo + ", fileName=" + fileName + ", filePath="
				+ filePath + "]";
	}
}
