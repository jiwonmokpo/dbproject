package evaluation;

public class Evaluation {
	
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getProfessorNmae() {
		return professorNmae;
	}
	public void setProfessorNmae(String professorNmae) {
		this.professorNmae = professorNmae;
	}
	public String getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(String lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getEvaluationDivied() {
		return evaluationDivied;
	}
	public void setEvaluationDivied(String evaluationDivied) {
		this.evaluationDivied = evaluationDivied;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getCreditScore() {
		return creditScore;
	}
	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}
	public String getComfortableScore() {
		return comfortableScore;
	}
	public void setComfortableScore(String comfortableScore) {
		this.comfortableScore = comfortableScore;
	}
	public String getLectureScore() {
		return lectureScore;
	}
	public void setLectureScore(String lectureScore) {
		this.lectureScore = lectureScore;
	}
	public int getLikcecount() {
		return likcecount;
	}
	public void setLikcecount(int likcecount) {
		this.likcecount = likcecount;
	}
	
	public Evaluation() {
		
	}
	
	public Evaluation(int evaluationID, String userID, String lectureName, String professorNmae, String lectureYear,
			String semesterDivide, String evaluationDivied, String evaluationContent, String totalScore,
			String creditScore, String comfortableScore, String lectureScore, int likcecount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.lectureName = lectureName;
		this.professorNmae = professorNmae;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.evaluationDivied = evaluationDivied;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.creditScore = creditScore;
		this.comfortableScore = comfortableScore;
		this.lectureScore = lectureScore;
		this.likcecount = likcecount;
	}
	int evaluationID;
	String userID;
	String lectureName;
	String professorNmae;
	String lectureYear;
	String semesterDivide;
	String evaluationDivied;
	String evaluationContent;
	String totalScore;
	String creditScore;
	String comfortableScore;
	String lectureScore;
	int likcecount;
	

}
