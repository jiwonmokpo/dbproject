<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="msg.*, util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("memberID") != null) {
		userID = (String) session.getAttribute("memberID");
	}
	
	String recevier = null;
	String msgTitle = null;
	String msgContent = null;

	if(request.getParameter("recevier") != null)
		recevier = request.getParameter("recevier");
	if(request.getParameter("msgTitle") != null)
		msgTitle = request.getParameter("msgTitle");
	if(request.getParameter("msgContent") != null)
		msgContent = request.getParameter("msgContent");
	
	if(msgTitle.equals("") || msgContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('쪽지) 입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	MsgDAO msgDAO = new MsgDAO();
	int result = msgDAO.writemsg(new Msg(0, userID, recevier, msgTitle, msgContent));
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('쪽지 등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('쪽지 보내기에 성공했습니다.');");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>