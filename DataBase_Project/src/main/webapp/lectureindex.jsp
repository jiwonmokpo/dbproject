<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<meta name="veiwport" content="width=device-width", initial-scale="1", shrink-to-fit=no">

<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<title>강의평가 웹사이트</title>
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
		<section class="container">
		<form method="get" action="./lectureindex.jsp" class="form-inline mt-3">
			<select name = "lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공필수">전공필수</option>
				<option value="전공선택">전공선택</option>
				<option value="전공교양">전공교양</option>
				<option value="기타">기타</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
			</form>
			<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">컴퓨터개론&nbsp;<small>박지원</small></div>
					<div class="col-4 text-right">종합<span style="color:red;">A</span></div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					정말 좋은 강의에요.&nbsp;<small>(2022년 겨울학기)</small>
				</h5>
				<p class="card-text">강의가 좋았어요.</p>
				<div class="row">
					<div class="col-9 text-left">
					성적<span style="color:red;">A</span>
					널널<span style="color:red;">B</span>
					강의<span style="color:red;">C</span>
					<span style=color:green;">(추천 : 15)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onclick="return confirm('추천하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
		</section>

		<!-- 강의 등록 -->
		<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">평가등록</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="./evaluationRegisterAction.jsp" method="post">
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>강의명</label>
									<input type="text" name="lectureName" class="form-control" maxlength="20">
								</div> 
								<div class="form-group col-sm-6">
									<label>교수명</label>
									<input type="text" name="professorName" class="form-control" maxlength="20">
								</div> 
							</div>
								<div class="form-row">
									<div class="form-group col-sm-4">
									<label>수강년도</label>
										<select name="lectureYear" class="form-control">
											<option value="2011">2011</option>
											<option value="2012">2012</option>
											<option value="2013">2013</option>
											<option value="2014">2014</option>
											<option value="2015">2015</option>
											<option value="2016">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
											<option value="2021">2021</option>
											<option value="2022" selected>2022</option>
											<option value="2023">2023</option>		
										</select>
									</div>
									<div class="form-group col-sm-4">
										<label>수강학기</label>
										<select name="semesterDivide" class="form-control">
											<option value="1학기" selected>1학기</option>
											<option value="여름학기">계절학기-여름</option>
											<option value="2학기">2학기</option>
											<option value="겨울학기">계절학기-겨울</option>
										</select>
									</div>
									<div class="form-group col-sm-4">
										<label>강의 구분</label>
										<select name="lectureDivide" class="form-control">
											<option value="전공필수" selected>전공필수</option>
											<option value="전공선택">전공선택</option>
											<option value="전공교양">전공교양</option>
											<option value="기타">기타</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label>제목</label>
									<input type="text" name="evaluationTime" class="form-control" maxlength="30">
								</div>
								<div class="form-group">
									<label>내용</label>
									<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
								</div>
								<div class="form-row">
									<div class="form-group col-sm-3">
										<label>종합</label>
										<select name="totalScore" class="form-control">
											<option value="A" selected>A</option>
											<option value="B">B</option>
											<option value="C">C</option>
											<option value="D">D</option>
											<option value="F">F</option>
										</select>
									</div>
									<div class="form-group col-sm-3">
										<label>성적</label>
										<select name="creditScore" class="form-control">
											<option value="A" selected>A</option>
											<option value="B">B</option>
											<option value="C">C</option>
											<option value="D">D</option>
											<option value="F">F</option>
										</select>
									</div>
									<div class="form-group col-sm-3">
										<label>널널</label>
										<select name="comfortableScore" class="form-control">
											<option value="A" selected>A</option>
											<option value="B">B</option>
											<option value="C">C</option>
											<option value="D">D</option>
											<option value="F">F</option>
										</select>
									</div>
									<div class="form-group col-sm-3">
										<label>강의</label>
										<select name="lectureScore" class="form-control">
											<option value="A" selected>A</option>
											<option value="B">B</option>
											<option value="C">C</option>
											<option value="D">D</option>
											<option value="F">F</option>
										</select>
									</div>
								</div>
								
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
									<button type="submit" class="btn btn-primary">등록하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<!--신고하기 -->
			<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">신고하기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="./reportACtion.jsp" method="post">
								<div class="form-group">
									<label>신고제목</label>
									<input type="text" name="reportTitle" class="form-control" maxlength="30">
								</div>
								<div class="form-group">
									<label>신고내용</label>
									<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
									<button type="submit" class="btn btn-danger">신고하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
				Copyright &copy; 2022 박지원 ALL Rights Reserved.
			</footer>
	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>