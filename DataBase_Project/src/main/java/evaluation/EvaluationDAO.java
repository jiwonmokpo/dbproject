package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;
import util.DatabaseUtil;

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
		String SQL = "SELECT evaluationID FROM evaluation ORDER BY evaluationID DESC";
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
	
	
	public int write(Evaluation evaluation) {
		String sql = "INSERT INTO evaluation VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, evaluation.getUserID().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, evaluation.getLectureName().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4, evaluation.getProfessorName().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(5, evaluation.getLectureYear());
			pstmt.setString(6, evaluation.getSemesterDivide().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, evaluation.getLectureDivide().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluation.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, evaluation.getEvaluationContent().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, evaluation.getTotalScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, evaluation.getCreditScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, evaluation.getComfortableScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(13, evaluation.getLectureScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
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
	
	public ArrayList<Evaluation> getList(int pageNumber) {
		String SQL = "SELECT*FROM (SELECT*FROM Evaluation WHERE EvaluationID < ? ORDER BY EvaluationID DESC) WHERE ROWNUM <=10";
		ArrayList<Evaluation> list = new ArrayList<Evaluation>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Evaluation evaluation = new Evaluation();
				evaluation.setEvaluationID(rs.getInt(1));
				evaluation.setUserID(rs.getString(2));
				evaluation.setLectureName(rs.getString(3));
				evaluation.setProfessorName(rs.getString(4));
				evaluation.setLectureYear(rs.getInt(5));
				evaluation.setSemesterDivide(rs.getString(6));
				evaluation.setLectureDivide(rs.getString(7));
				evaluation.setEvaluationTitle(rs.getString(8));
				evaluation.setEvaluationContent(rs.getString(9));
				evaluation.setTotalScore(rs.getString(10));
				evaluation.setCreditScore(rs.getString(11));
				evaluation.setComfortableScore(rs.getString(12));
				evaluation.setLectureScore(rs.getString(13));
				evaluation.setLikeCount(rs.getInt(14));
				list.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
	
	public int like(String evaluationID) {
		String sql = "UPDATE evaluation SET likeCount = likeCount + 1 WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
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
		return -1; 
	}
	
	public int delete(String evaluationID) {
		String sql = "DELETE FROM evaluation WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
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
		return -1; 
	}
	
	public String getUserID(String evaluationID) {
		String sql = "SELECT userID FROM evaluation WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
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
		return null; 
	}
	public ArrayList<Evaluation> getevSearch(String searchField, String searchText){
	      ArrayList<Evaluation> list = new ArrayList<Evaluation>();
	      String SQL ="select * from evaluation WHERE "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	                SQL ="SELECT * FROM(SELECT*FROM evaluation WHERE "+searchField.trim()+" LIKE '%"+searchText.trim()+"%' ORDER BY evaluationID DESC) WHERE ROWNUM <=10";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	         while(rs.next()) {
	 			Evaluation evaluation = new Evaluation();
				evaluation.setEvaluationID(rs.getInt(1));
				evaluation.setUserID(rs.getString(2));
				evaluation.setLectureName(rs.getString(3));
				evaluation.setProfessorName(rs.getString(4));
				evaluation.setLectureYear(rs.getInt(5));
				evaluation.setSemesterDivide(rs.getString(6));
				evaluation.setLectureDivide(rs.getString(7));
				evaluation.setEvaluationTitle(rs.getString(8));
				evaluation.setEvaluationContent(rs.getString(9));
				evaluation.setTotalScore(rs.getString(10));
				evaluation.setCreditScore(rs.getString(11));
				evaluation.setComfortableScore(rs.getString(12));
				evaluation.setLectureScore(rs.getString(13));
				evaluation.setLikeCount(rs.getInt(14));
				list.add(evaluation);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;
	   }
}
