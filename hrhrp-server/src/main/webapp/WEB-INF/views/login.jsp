<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>HRHRP</title>

<!-- Bootstrap -->
<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<!-- 
<style type="text/css">
.map{
	float: left;
}
</style>
-->
</head>
<body>

	<div class="container">

		<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">HRHRP</a>
			</div>

			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="#">Upload</a></li>
					<li class="active"><a href="#">Quiz <span class="sr-only">(current)</span></a></li>
				</ul>

				<%		
				String username = (String) request.getAttribute("username");
				if (username != null) {						
				%>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<c:url value="j_spring_security_logout" />">${username}</a>
					</li>
				</ul>
				<%
				} else {
				%>
				<form class="navbar-form navbar-right" method="post"
					action="loginProcess">
					<div class="form-group">
						<input type="text" placeholder="Email" class="form-control"
							name="id">
					</div>
					<div class="form-group">
						<input type="password" placeholder="Password" class="form-control"
							name="pw">
					</div>
					<button type="submit" class="btn btn-success">로그인</button>
				</form>
				<%
				}
				%>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		</nav>

		<!-- Main jumbotron for a primary marketing message or call to action -->
		<div class="jumbotron">
			<div class="container">
				<h1>HRHRP</h1>
				<p>
					일상으로부터 당신의 기억을 지켜내세요. <br /> 본 서비스는 회상요법을 통해서 치매를 예방하고 환자의 상태를 호전
					시킬 수 있습니다.
				</p>
				<%		
				if (username == null) {						
				%>
				<p><a class="btn btn-lg btn-primary" data-toggle="collapse" data-target="#viewdetails">가입하기 &raquo;</a></p>
				<div class="col-md-4 collapse-group">		
					<form class="collapse" method="post" action="<c:url value='/api/signup'/>" id="viewdetails">
						<div class="form-group">
							<input type="text" placeholder="Email" class="form-control" name="id">
						</div>
						<div class="form-group">
							<input type="name" placeholder="Name" class="form-control" name="name">
						</div>
						<div class="form-group">
							<input type="password" placeholder="Password" class="form-control" name="pw">
						</div>
						<button type="submit" class="btn btn-success">회원가입</button>
					</form>	
				</div>
				<%
				}
				%>

			</div>
		</div>

		<div class="container">

			<!-- Example row of columns -->
			<div class="row">
				<div class="col-md-4">
					<h2>Upload</h2>
					<p>
						촬영된 일상의 사진을 올려주세요. Wearable Camera를 이용하면 보다 손 쉽게 당신의 일상을 기록할 수
						있습니다. <br /> <br /> <br /> <br />
					</p>
					<p>
						<a class="btn btn-default" href="#" role="button">바로가기 &raquo;</a>
					</p>
				</div>
				<div class="col-md-4">
					<h2>Analyzing</h2>
					<p>일상과 관련된 퀴즈를 만들어 내기 위해서 사진들을 분석합니다. 일상이 기록된 사진들로 부터 만났던 사람,
						물건, 장소, 날씨 등을 추출합니다. 추출된 정보를 이용하여 사용자의 회상을 도울 수 있는 사진들을 선별하여 퀴즈를
						생성합니다.</p>

				</div>
				<div class="col-md-4">
					<h2>Quiz</h2>
					<p>사용자에게 회상을 도울 수 있는 퀴즈를 제공합니다. 일상과 관련된 퀴즈를 풀면서 사용자가 자연스럽게 회상을
						할 수 있도록 도움을 줍니다. 사용자가 퀴즈를 풀었던 정보를 기록하여, 상대적으로 회상 능력이 약한 부분을 향상 시킬
						수 있는 퀴즈를 제공합니다.</p>
					<p>
						<a class="btn btn-default" href="#" role="button">바로가기 &raquo;</a>
					</p>
				</div>
			</div>

			<hr>

			<footer>
			<p class="text-right">&copy; Datamining Lab. KAIST 2015</p>
			</footer>

		</div>
	</div>
	<!-- container -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>