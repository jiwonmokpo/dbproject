<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="evaluation.Evaluation" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("memberID") != null) {
			userID = (String) session.getAttribute("memberID");
		}
		if (request.getParameter("evsearchField") == "0" || request.getParameter("evsearchText") == null
				|| request.getParameter("evsearchField").equals("0")
				|| request.getParameter("evsearchText").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		//현재 페이지가 몇번째 페이지 인가
		int pageNumber = 1;//기본적으로 1페이지
		if (request.getParameter("pageNumber") != null)
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	%>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class = "nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp">게시판</a></li>
			<li class="active"><a href="lectureindex.jsp">강의평가</a></li>
		</ul>
		<%
			if(userID == null) {
		%>
		<ul class = "nav navbar-nav navbar-right">
			<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>	
		<%		
			} else {
		%>
		<ul class = "nav navbar-nav navbar-right">
			<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>	
		<%
			}
		%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="from-control" name="searchField">
							<option value="0">선택</option>
							<option value="bbsTitle">제목</option>
							<option value="userID">작성자</option>
						</select></td>
						<td>
							<input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>
				</table>	
			</form>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table class="active table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">수강학기</th>
						<th style="background-color: #eeeeee; text-align: center;">종합평가</th>
						<th style="background-color: #eeeeee; text-align: center;">강의명</th>
						<th style="background-color: #eeeeee; text-align: center;">교수</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
						<th style="background-color: #eeeeee; text-align: center;">추천수</th>
					</tr>
				</thead>
				<tbody>
					<%
					EvaluationDAO evaluationDAO = new EvaluationDAO();
					ArrayList<Evaluation> evlist = evaluationDAO.getSearchev(request.getParameter("evsearchField"),
					request.getParameter("evsearchText"));
						if (evlist.size() == 0) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('검색결과가 없습니다.')");
						script.println("history.back()");
						script.println("</script>");
						} 
						for (int i = 0; i < evlist.size(); i++) {
					%>
					<tr>
						<%--현재 게시글에 대한 정보 --%>
						<td><%= evlist.get(i).getEvID() %></td>
						<td><%= evlist.get(i).getUserID() %></td>
						<td><%= evlist.get(i).getSemester() %></td>
						<td><%= evlist.get(i).getRank() %></td>
						<td><a href="lectureview.jsp?EvID=<%= evlist.get(i).getEvID() %>"><%= evlist.get(i).getEvtitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
						<td><%= evlist.get(i).getProfessor() %></td>
						<td><%= evlist.get(i).getEvdate().substring(0, 10) %></td>
						<td><%= evlist.get(i).getEvcount() %></td>
						<td><%= evlist.get(i).getEvlike() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
				<a href="evwrite.jsp" class="btn btn-success pull-right">글쓰기</a>
				<a href="lectureindex.jsp" class="btn btn-success pull-left">목록</a>
			</div>

		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>