package msg;

public class Msg {
	
	int msgID;
	String userID;
	String recevier;
	String msgTitle;
	String msgContent;
	
	public Msg() {
		
	}
	
	public Msg(int msgID, String userID, String recevier, String msgTitle, String msgContent) {
		super();
		this.msgID = msgID;
		this.userID = userID;
		this.recevier = recevier;
		this.msgTitle = msgTitle;
		this.msgContent = msgContent;
	}
	public int getMsgID() {
		return msgID;
	}

	public void setMsgID(int msgID) {
		this.msgID = msgID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRecevier() {
		return recevier;
	}
	public void setRecevier(String recevier) {
		this.recevier = recevier;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	
	

}
