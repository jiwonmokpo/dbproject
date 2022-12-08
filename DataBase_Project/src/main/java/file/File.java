package file;

public class File {
	
	String fileName;
	String fileRealName;
	int bbsID;

	public File(String fileName, String fileRealName, int bbsID) {
		super();
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.bbsID = bbsID;
	}
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
}
