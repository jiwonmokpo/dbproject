package msg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class MsgDAO {

		private Connection conn;
		private ResultSet rs;
		
		public MsgDAO() {
			try {
				String driverName = "oracle.jdbc.driver.OracleDriver";	
				String url = "jdbc:oracle:thin:@localhost:1521:system";
				Class.forName(driverName);
				conn = DriverManager.getConnection(url,"c##DBadmin", "0000");
			} catch (Exception e) {
				e.printStackTrace();
		}
	}
		public int getNext() {
			String SQL = "SELECT MSGID FROM MSG ORDER BY MSGID DESC";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return rs.getInt(1) +1;
				}
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		public int writemsg(Msg msg) {
			String sql = "INSERT INTO MSG VALUES(?, ?, ?, ?, ?)";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, msg.getUserID().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(3, msg.getRecevier().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(4, msg.getMsgTitle().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(5, msg.getMsgContent().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
				return pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try { if(conn != null) conn.close(); }
				catch (Exception e) { e.printStackTrace(); }
				try { if(pstmt != null) pstmt.close(); }
				catch (Exception e) { e.printStackTrace(); }
				try { if(rs != null) rs.close(); }
				catch (Exception e) { e.printStackTrace(); }
			}
			return -1; //데이터 베이스 오류
		}
	
	public ArrayList<Msg> getList(int pageNumber) {
		String SQL = "SELECT*FROM (SELECT*FROM MSG WHERE msgID < ? ORDER BY msgID DESC) WHERE ROWNUM <=10";
		ArrayList<Msg> list = new ArrayList<Msg>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Msg msg = new Msg();
				msg.setMsgID(rs.getInt(1));
				msg.setUserID(rs.getString(2));
				msg.setRecevier(rs.getString(3));
				msg.setMsgTitle(rs.getString(4));
				msg.setMsgContent(rs.getString(5));
				list.add(msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
	private String getRecevier() {
		// TODO Auto-generated method stub
		return null;
	}
	
}