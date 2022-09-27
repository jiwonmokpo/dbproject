package bbscomment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class BbscommentDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbscommentDAO() {
		try {
			String driverName = "oracle.jdbc.driver.OracleDriver";	
			String url = "jdbc:oracle:thin:@localhost:1521:system";
			Class.forName(driverName);
			conn = DriverManager.getConnection(url,"c##DBadmin", "0000");
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	}
	public String getDate() {
		String SQL = "SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";	
	}
	
	
	public int getNext() {
		String SQL="SELECT commentID from BBSCOMMENT order by commentID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String commentContent, String userID, int bbsID) {
		String SQL="insert into BBSCOMMENT VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, commentContent);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, bbsID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Bbscomment> getList(int bbsID){
		String SQL="SELECT*FROM (SELECT*FROM bbscomment WHERE bbsID = ? AND COMMENTAvailable = 1 ORDER BY bbsID DESC) WHERE ROWNUM <=10";
		ArrayList<Bbscomment> list = new ArrayList<Bbscomment>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbscomment bbscomment = new Bbscomment();
				bbscomment.setCommentContent(rs.getString(1));
				bbscomment.setCommentID(rs.getInt(2));
				bbscomment.setUserID(rs.getString(3));
				bbscomment.setCommentAvailable(rs.getInt(4));
				bbscomment.setCommentDate(rs.getString(5));
				bbscomment.setBbsID(rs.getInt(6));
				list.add(bbscomment);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Bbscomment getComment(int commentID) {
		String SQL="SELECT * from bbscomment where commentID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Bbscomment bbscomment = new Bbscomment();
				bbscomment.setCommentContent(rs.getString(1));
				bbscomment.setCommentID(rs.getInt(2));
				bbscomment.setUserID(rs.getString(3));
				bbscomment.setCommentAvailable(rs.getInt(4));
				bbscomment.setCommentDate(rs.getString(5));
				bbscomment.setBbsID(rs.getInt(6));
				return bbscomment;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, int commentID,String commentContent ) {
		String SQL="update bbscomment set commentContent = ? where bbsID = ? and commentID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, commentContent);//물음표의 순서
			pstmt.setInt(2, bbsID);
			pstmt.setInt(3, commentID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int commentID) {
		String SQL = "update BBSCOMMENT set commentAvailable = 0 where commentID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	

}
