package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import bbs.Bbs;

public class FileDAO {
	private Connection conn;
	private ResultSet rs;
	
	public FileDAO() {
		try {
			String driverName = "oracle.jdbc.driver.OracleDriver";	
			String url = "jdbc:oracle:thin:@localhost:1521:system";
			Class.forName(driverName);
			conn = DriverManager.getConnection(url,"c##DBadmin", "0000");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int upload(String fileName, String fileRealName) {
		String SQL = "INSERT INTO FILEDB VALUES (?, ?)";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
