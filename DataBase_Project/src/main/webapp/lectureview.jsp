<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="evaluation.Evaluation" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="bbscomment.Bbscomment" %>
<%@ page import="bbscomment.BbscommentDAO" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<meta name="veiwport" content = "width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>강의 평가</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("memberID") != null) {
			userID = (String) session.getAttribute("memberID");
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
		
		int commentID = 0;
		if(request.getParameter("commentID")!=null)
			commentID=Integer.parseInt(request.getParameter("commentID"));
			Bbscomment bbscomment = new BbscommentDAO().getComment(commentID);
		
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<td style="width:20%;">작성자</td>
						<td colspan="2"><%= evaluation.getSemester() %></td>
					</tr>
					<tr>
					<td>강의명</td>
						<td colspan="2"><%= evaluation.getProfessor() %></td>
					</tr>
					<tr>
						<td>교수명</td>
						<td colspan="2"><%= evaluation.getUserID() %></td>
					</tr>
					<tr>
						<td>수강학기</td>
						<td colspan="2"><%= evaluation.getRank() %></td>
					</tr>
					<tr>
						<td>종합평가</td>
						<td colspan="2"><%= evaluation.getEvtitle() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= evaluation.getEvdate().substring(0, 10) %></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td colspan="2"><%= evaluation.getEvcount() + 1 %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= evaluation.getEvcontent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="lectureindex.jsp" class="btn btn-primary">목록</a>
			<%
				
			%>
					<a href="evupdate.jsp?EvID=<%= EvID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="evdeleteAction.jsp?EvID=<%= EvID %>" class="btn btn-primary">삭제</a>
			<%
				
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</div>	
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
			<tbody>
				<tr>
					<td align = "left" bgcolor="skyblue">댓글</td>
				</tr>
				<tr>
			</tbody>
					<% 
                    BbscommentDAO bbscommentDAO = new BbscommentDAO();
                    ArrayList<Bbscomment> list = bbscommentDAO.getList(EvID);
                    for(int i=0; i<list.size(); i++){
					%>
				<div class="container">
						<div class="row">
							<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
							<tbody>
								<tr>
									<td align="left"><%=list.get(i).getUserID()%></td>
									<td align="right"><%=list.get(i).getCommentDate() %></td>
								</tr>
								<tr>
									<td align="left"><%=list.get(i).getCommentContent() %></td>
                  					<td align="right"><a href="commentUpdate.jsp?bbsID=<%=EvID%>&commentID=<%=list.get(i).getCommentID()%>" class="btn btn-warning">수정</a>
                  					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp?bbsID=<%=EvID%>&commentID=<%=list.get(i).getCommentID() %>" class="btn btn-danger">삭제</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
					<%
						}
					%>
			</table>
		</div>
	</div>
	<br>
	<div class="container">
		<div class="row">
			<form method="post" action="submitAction.jsp?bbsID=<%=EvID %>">
				<table class="table table-bordered" style="text-align:center; border:1px solid #dddddd">
				<tbody>
					<tr>
						<td align="left"><%=userID %></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control" placeholder="댓글 쓰기" name="commentContent" maxlength="300"></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-success pull-right" value="댓글 쓰기">
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>