<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="evaluation" class="evaluation.Evaluation" scope="page" />
<jsp:setProperty name="evaluation" property="semester" />
<jsp:setProperty name="evaluation" property="rank" />
<jsp:setProperty name="evaluation" property="evtitle" />
<jsp:setProperty name="evaluation" property="professor" />
<jsp:setProperty name="evaluation" property="evcontent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<title>Database Project</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("memberID") !=null){
		userID = (String) session.getAttribute("memberID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp");
		script.println("</script>");
	} else {
		if(evaluation.getEvtitle() == null || evaluation.getEvcontent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			EvaluationDAO evaluationDAO = new EvaluationDAO();
			int result = evaluationDAO.evwrite(userID, evaluation.getSemester(), evaluation.getRank(), evaluation.getEvtitle(), evaluation.getProfessor(), evaluation.getEvcontent());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'lectureindex.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>