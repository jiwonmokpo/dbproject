<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder" %>  
<%@ page import="member.*, evaluation.*" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="msg.Msg" %>
<%@ page import="msg.MsgDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<meta name="veiwport" content = "width=device-width" initial-scale="1">
<link rel="stylesheet" href="./css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>MNU Town</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("memberID") != null) {
			userID = (String) session.getAttribute("memberID");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
		int pageNumber = 0;
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
			<a class="navbar-brand" href="main.jsp">MNU Town</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class = "nav navbar-nav">
			<li class="active"><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp">게시판</a></li>
			<li><a href="index.jsp">강의평가</a></li>
			<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">미니게임<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="ladder.jsp">사다리</a></li>
						<li><a href="roulette.jsp">룰렛</a></li>
						<li><a href="speedtest.jsp">반응속도</a></li>
					</ul>
				</li>
			
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
						<li><a href="userLogin.jsp">로그인</a></li>
						<li><a href="userJoin.jsp">회원가입</a></li>
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
						aria-expanded="false">쪽지<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a data-toggle="modal" href="#msgModal">쪽지보내기</a></li>
						<li><a data-toggle="modal" href="#msgbox">쪽지보관함</a></li>
					</ul>
				</li>
			<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userLogout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>	
		<%
			}
		%>
		</div>
	</nav>
	<!-- 더보기 페이지 -->
	<div class="container">
		<div class="jumbotron">
			<div class="container">
			<h1>DataBaseProject</h1>
			<p>강의평가 프로젝트 과제를 위한 홈페이지 입니다.</p>
			<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	
	
	
	
	<!-- 쪽지기능 -->
	<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">쪽지보내기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="msgAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-13">
							<label>받는 사람</label>
								<input type="text" name="recevier" class="form-control" maxlength="30"/>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="msgTitle" class="form-control" maxlength="100">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="msgContent" class="form-control" maxlength="1024" style="height:180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">보내기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 쪽지함 기능 -->
	<%
	ArrayList<Msg> msgList = new ArrayList<Msg>();
	msgList = new MsgDAO().getList(pageNumber);
	
	if(msgList != null) 
		for(int i = 0; i < msgList.size(); i++) {
			if(i == 10) break;
			Msg msg = msgList.get(i);
	%>
	<div class="modal fade" id="msgbox" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">쪽지함</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="card bg-light mt-3">
						<div class="card-header bg-light"></div>
						<div class="card-body">
							<h5 class="card-title">
								<%=msg.getMsgTitle()%>&nbsp;<small>(<%=msg.getUserID()%>님)
								</small>
							</h5>
							<p class="card-text"><%=msg.getMsgContent()%>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%
	}
	%>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>