package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import evaluation.Evaluation;

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
	public String getevDate() {
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
	
	public int getevNext() {
		String SQL = "SELECT EVID FROM EVALUATION ORDER BY EVID DESC";
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
	public int evwrite(String userID, String semester, String rank, String evtitle, String professor, String evcontent) {
		String SQL = "INSERT INTO EVALUATION VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getevNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, semester);
			pstmt.setString(4, rank);
			pstmt.setString(5, evtitle);
			pstmt.setString(6, professor);
			pstmt.setString(7, getevDate());
			pstmt.setString(8, evcontent);
			pstmt.setInt(9, 1);
			pstmt.setInt(10, getevCount(0, 0));
			pstmt.setInt(11, getevlike(0, 0));
	
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	public ArrayList<Evaluation> getevList(int pageNumber) {
		String SQL = "SELECT*FROM (SELECT*FROM Evaluation WHERE EvID < ? AND EVAVAILABLE = 1 ORDER BY EvID DESC) WHERE ROWNUM <=10";
		ArrayList<Evaluation> list = new ArrayList<Evaluation>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getevNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Evaluation evaluation = new Evaluation();
				evaluation.setEvID(rs.getInt(1));
				evaluation.setUserID(rs.getString(2));
				evaluation.setSemester(rs.getString(3));
				evaluation.setRank(rs.getString(4));
				evaluation.setEvtitle(rs.getString(5));
				evaluation.setProfessor(rs.getString(6));
				evaluation.setEvdate(rs.getString(7));
				evaluation.setEvcontent(rs.getString(8));
				evaluation.setEvavailable(rs.getInt(9));
				evaluation.setEvcount(rs.getInt(10));
				evaluation.setEvlike(rs.getInt(11));
				list.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
	
	public boolean nextevPage(int pageNumber) {
		String SQL = "SELECT * FROM Evaluation WHERE evID < ? AND evAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getevNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Evaluation getEvaluation(int EvID) {
		String SQL = "SELECT * FROM EVALUATION WHERE EvID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, EvID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Evaluation evaluation = new Evaluation();
				evaluation.setEvID(rs.getInt(1));
				evaluation.setSemester(rs.getString(2));
				evaluation.setRank(rs.getString(3));
				evaluation.setEvtitle(rs.getString(4));
				evaluation.setProfessor(rs.getString(5));
				evaluation.setUserID(rs.getString(6));
				evaluation.setEvdate(rs.getString(7));
				evaluation.setEvcontent(rs.getString(8));
				evaluation.setEvavailable(rs.getInt(9));
				int evcount=rs.getInt(10);
				int evlike=rs.getInt(11);
				evaluation.setEvcount(evcount);
				evcount++;
				/*evaluation.setEvlike(evlike);*/
				/*evlike++;*/
				getevCount(evcount,EvID);
				/* getevlike(evlike,EvID); */
				return evaluation;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int getevlike(int evlike, int evID) {
		String SQL = "UPDATE EVALUATION SET EVLIKE = ? WHERE EVID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, evlike);
			pstmt.setInt(2, evID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getevCount(int evcount, int evID) {
		String SQL = "UPDATE EVALUATION SET EVCOUNT = ? WHERE EVID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, evcount);
			pstmt.setInt(2, evID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public ArrayList<Evaluation> getevSearch(String searchField, String searchText){
	      ArrayList<Evaluation> list = new ArrayList<Evaluation>();
	      String SQL ="select * from EVALUATION WHERE "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	                SQL ="SELECT * FROM(SELECT*FROM EVALUATION WHERE "+searchField.trim()+" LIKE '%"+searchText.trim()+"%' ORDER BY evID DESC) WHERE ROWNUM <=10";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	         while(rs.next()) {
	        	Evaluation evaluation = new Evaluation();
				evaluation.setEvID(rs.getInt(1));
				evaluation.setSemester(rs.getString(2));
				evaluation.setRank(rs.getString(3));
				evaluation.setEvtitle(rs.getString(4));
				evaluation.setProfessor(rs.getString(5));
				evaluation.setUserID(rs.getString(6));
				evaluation.setEvdate(rs.getString(7));
				evaluation.setEvcontent(rs.getString(8));
	            list.add(evaluation);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;
	   }
	
	
	
	public int evupdate(int EvID, String professor, String semester, String rank, String evtitle, String evcontent) {
		String SQL = "UPDATE Evaluation SET evtitle = ?, professor = ?, semester =?, rank = ?, evcontent = ? WHERE EvID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evtitle);
			pstmt.setString(2, professor);
			pstmt.setString(3, semester);
			pstmt.setString(4, rank);
			pstmt.setString(5, evcontent);
			pstmt.setInt(6, EvID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int evdelete(int EvID) {
		String SQL = "UPDATE Evaluation SET evavailable=0 WHERE EvID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, EvID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}

	
	public int getevserachCount() {
		String SQL = "select count(*) from EVALUATION";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public ArrayList<Evaluation> getSearchev(String evsearchField, String evsearchText){
	      ArrayList<Evaluation> evlist = new ArrayList<Evaluation>();
	      String SQL ="select * from Evaluation WHERE "+evsearchField.trim();
	      try {
	            if(evsearchText != null && !evsearchText.equals("") ){
	                SQL ="SELECT * FROM(SELECT*FROM Evaluation WHERE "+evsearchField.trim()+" LIKE '%"+evsearchText.trim()+"%' ORDER BY EvID DESC) WHERE ROWNUM <=10";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	         while(rs.next()) {
	        	Evaluation evaluation = new Evaluation();
				evaluation.setEvID(rs.getInt(1));
				evaluation.setSemester(rs.getString(2));
				evaluation.setRank(rs.getString(3));
				evaluation.setEvtitle(rs.getString(4));
				evaluation.setProfessor(rs.getString(5));
				evaluation.setUserID(rs.getString(6));
				evaluation.setEvdate(rs.getString(7));
				evaluation.setEvcontent(rs.getString(8));
				evlist.add(evaluation);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return evlist;
	   }
	
}
	
