<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<meta name="veiwport" content = "width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>미니게임 사이트</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>reaction-time</title>
    <style>
      #screen {
        width: 500px;
        height: 300px;
        text-align: center;
        user-select: none; 
      }
      #screen.waiting {
        background-color: aqua;
      }
      #screen.ready {
        background-color: red;
        color: white;
      }
      #screen.now {
        background-color: greenyellow;
      }
    </style>
</head>
<body>
<% 
		String userID = null;
		if(session.getAttribute("memberID") != null) {
			userID = (String) session.getAttribute("memberID");
		}
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
			<li class="active"><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp">게시판</a></li>
			<li><a href="lectureindex.jsp">강의평가</a></li>
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
						<li><a href="note.jsp">쪽지보내기</a></li>
						<li><a href="notebox.jsp">쪽지함</a></li>
					</ul>
				</li>
			</ul>	
		<%
			}
		%>
		</div>
	</nav>
    <div id="screen" class="waiting" style="position: absolute;left: 30%;top:10%;">>클릭해서 시작하세요</div>
    	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
    	<script src="js/speedtest.js?version=1"></script>
</body>
</html>