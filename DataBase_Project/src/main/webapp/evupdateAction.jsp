<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.Evaluation" %>
<%@ page import="evaluation.EvaluationDAO" %> 
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
	}
	int EvID = 0;
	if (request.getParameter("EvID") != null) {
		EvID = Integer.parseInt(request.getParameter("EvID"));
	}
	if (EvID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글입니다.')");
		script.println("location.href = 'bbs.jsp");
		script.println("</script>");
	}
	Evaluation evaluation = new EvaluationDAO().getEvaluation(EvID);
	if (!userID.equals(evaluation.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp");
		script.println("</script>");
	} else {
		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
			|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			EvaluationDAO evaluationDAO = new EvaluationDAO();
			int result = evaluationDAO.evupdate(EvID, request.getParameter("evtitle"),
					request.getParameter("professor"),
					request.getParameter("semester"),
					request.getParameter("rank"),
					request.getParameter("evcontent"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>