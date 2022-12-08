<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<meta name="veiwport" content = "width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>MNU Town</title>
<style>
   body {
   background-image: url('image/v1051-30b.jpg');
   background-size: cover;
   }
   input{
   margin: 22px; 
   text-align: center;
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
			<a class="navbar-brand" href="main.jsp">MNU Town</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class = "nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
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
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userLoginAction.jsp">로그아웃</a></li>
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
<div style="left:100px;">
    <h3>사다리타기</h3>
</div>
    <div style="dispslay: inline-block;width: 602px;height: 402px;position: absolute;left:25%;top:10%;">
        	    <div>
        <input size="8" type= "text">
        <input size="8" type= "text">
        <input size="8" type= "text">
        <input size="8" type= "text">
        <input size="8" type= "text">
        </div>
        <canvas id='canvas' width="600" height="400"> </canvas>
        <div>
        <input size="8" type= "text">
        <input size="8" type= "text">
        <input size="8" type= "text">
        <input size="8" type= "text">
        <input size="8" type= "text">
        </div>
        <div>
            <br>
            <button type="button" id="btn1">1번</button>
            <button type="button" id="btn2">2번</button>
            <button type="button" id="btn3">3번</button>
            <button type="button" id="btn4">4번</button>
            <button type="button" id="btn5">5번</button>
        </div>

    </div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src='js/ladder.js'></script>
</body>
</html>