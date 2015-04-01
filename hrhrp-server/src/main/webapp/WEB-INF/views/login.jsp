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
				<form class="navbar-form navbar-right" method="post" action="loginProcess">
					<div class="form-group">
						<input type="text" placeholder="Email" class="form-control"
							name="email_signin">
					</div>
					<div class="form-group">
						<input type="password" placeholder="Password" class="form-control"
							name="password_signin">
					</div>
				
					<a href='#' class='btn btn-success' role='button' onclick='requestSignIn()'>로그인</a>

				</form>
				<%
				}
				%>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		</nav>

		<div id="warningDIV" class="alert alert-warning" role="alert" style="display:none;">
		</div>
			
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
							<input type="text" placeholder="Email" class="form-control" name="email_signup">
						</div>
						<div class="form-group">
							<input type="text" placeholder="Name" class="form-control" name="name_signup">
						</div>
						<div class="form-group">
							<input type="password" placeholder="Password" class="form-control" name="password_signup">
						</div>
						<a href='#' class='btn btn-success' role='button' onclick='requestSignUp()'>회원가입</a>
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

	<script type="text/javascript">
	function requestSignUp() {
		$("#warningDIV").hide();
		
		 var email = $('input:text[name="email_signup"]').val();
		 var name = $('input:text[name="name_signup"]').val();
		 var password = $('input:password[name="password_signup"]').val();
		 
		 if (email == null || email.length == 0) {
			 $("#warningDIV").html("이메일을 입력해 주세요.");
			 $("#warningDIV").show();
		 } else if (name == null || name.length == 0) {
			 $("#warningDIV").html("이름을 입력해 주세요.");
			 $("#warningDIV").show();
		 } else if (password == null || password.length == 0) {
			 $("#warningDIV").html("비밀번호를 입력해 주세요.");
			 $("#warningDIV").show();
		 } else {
			 $.ajax({
				  type: "POST",
				  url: 'api/signup',
				  data: {
					  "email": email,
					  "password":password,
					  "name": name
				  },
				  success: function(data) {
					  var msg = data["msg"];
					  var code = data["code"];
					  if (code == "SAME_EMAIL") {
						  $("#warningDIV").html("동일한 이메일 주소가 존재 합니다.");
						  $("#warningDIV").show();
					  } else if (code == "UNKNOWN") {
						  requestError();
					  } else if (code == "SUCCESS") {
						  requestSignInWithParms(email, password);
					  } else {
						  $("#warningDIV").html(msg);
						  $("#warningDIV").show();
					  }
				  },
				  error: requestError,
				  dataType: 'json'
			});
		 }	 
	}
	
	function requestSignIn() {
		 var email = $('input:text[name="email_signin"]').val();
		 var password = $('input:password[name="password_signin"]').val();
		 requestSignInWithParms(email, password);
	}
	
	function requestSignInWithParms(email, password) {
		$("#warningDIV").hide();	
		 if (email == null || email.length == 0) {
			 $("#warningDIV").html("이메일을 입력해 주세요.");
			 $("#warningDIV").show();
		 } else if (password == null || password.length == 0) {
			 $("#warningDIV").html("비밀번호를 입력해 주세요.");
			 $("#warningDIV").show();
		 } else {
			 $.ajax({
				  type: "POST",
				  url: "loginProcess",
				  data: {
					  "id": email,
					  "pw": password,
				  },
				  success: function(data) {
					
					 var msg = data["err_msg"];
					 if (msg == false) {
						 var url = data["target_url"];
						 location.href = url;
					  } else if (msg.indexOf("BadCredentialsException") != -1) {
						  $("#warningDIV").html("아이디와 비밀번호를 확인해주세요.");
						  $("#warningDIV").show();
					  } else {
						  $("#warningDIV").html(msg);
						  $("#warningDIV").show();
					  }		  
				  },
				  error: requestError,
				  dataType: 'json'
			});
		 }	 
	}
	
	function requestError(xhr,err) {
		$("#warningDIV").html("요청 실패! 다시 시도해주세요. <br/>" + xhr.responseText);
		$("#warningDIV").show();
	}
	
	</script>

</body>
</html>