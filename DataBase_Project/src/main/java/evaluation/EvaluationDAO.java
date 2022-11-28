package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EvaluationDAO {
	private Connection conn;
	private ResultSet rs;
	
	public EvaluationDAO() {
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
		String SQL = "SELECT EvaluationID FROM Evaluation ORDER BY EvaluationID DESC";
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
	

	public int write(String userID, String userid, String lectureName, String professorName, int lectureYear, String SemesterDivide,
			String LectureDivide, String EvaluationTitle, String EvaluationContent, String TotalScore, String CreditScore, String ComfortableScore, String LectureScore) {
		String SQL = "INSERT INTO Evaluation VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, lectureName);
			pstmt.setString(4, professorName);
			pstmt.setInt(5, lectureYear);
			pstmt.setString(6, SemesterDivide);
			pstmt.setString(7, LectureDivide);
			pstmt.setString(8, EvaluationTitle);
			pstmt.setString(9, EvaluationContent);
			pstmt.setString(10, TotalScore);
			pstmt.setString(11, CreditScore);
			pstmt.setString(12, ComfortableScore);
			pstmt.setString(13, LectureScore);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
	
