<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

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
				<a class="navbar-brand" href="<c:url value="/" />">HRHRP</a>
			</div>

			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="uploader">Upload</a></li>
					<li class="active"><a href="quiz">Quiz <span class="sr-only">(current)</span></a></li>
				</ul>

				<security:authorize access="!isAuthenticated()">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<c:url value="/" />">로그인이 필요합니다.</a>
						</li>
					</ul>
				</security:authorize>
				
				<security:authorize access="isAuthenticated()">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<c:url value="j_spring_security_logout" />"><security:authentication property="principal.username" /></a>
						</li>
					</ul>
				</security:authorize>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		</nav>

		<div class="container">
			<div id="infoDIV"></div>
			<div class="page-header" id="pageTitleDIV"></div>
			<div class="panel panel-primary">
	
				<div id="quizDIV" class="panel-heading"></div>
				<div id="inputDIV" class="panel-body text-center"></div>
	
			</div>
	
			<div id="nextDIV"></div>
		</div>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="resources/maphilight/jquery.maphilight.js"></script>
	<script type="text/javascript">
		var personIdx = 0;
		var personList = [];
		var quizList = [];
		var quizIdx = 0;

		function getPerson() {
			if (personIdx < personList.length) {
				
				$("#quizDIV").html("");
				$("#quizForImgDIV").html("");
				$("#inputDIV").html("");
				$("#nextDIV").html("");
				$("#pageTitleDIV").html("<h3>새롭게 발견된 사람 정보 입력</h3>");
				
				var person = personList[personIdx];
				var personId = person["person_id"];

				var faces = person["faces"];

				$("#quizDIV").html("다음사람의 이름과 본인과의 관계는 무엇입니까?" + "<br>");

				for (var i = 0; i < faces.length; i++) {
					var face = faces[i];
					var url = face["url"];

					
					$("#inputDIV").append("<div id='quizForImgDIV' class='panel-body center-block text-center'></div>");
					
					$("#quizForImgDIV").append("<div class='col-md-3 col-md-offset-4'><div class='thumbnail' id ='quizImgThumb'></div></div>");
					var div_width = $("#quizImgThumb").width();
					var div_height = $("#quizImgThumb").height();
					
					if (div_width == 0) {
						div_width = div_height;
					}
					
					if (div_height == 0) {
						div_height = div_width;
					}
					
					$("#quizImgThumb").append("<img class='map' id='map' usemap='#face' src='" + url + "' width=" + div_width + " height=" + div_height + ">");// +"<input type='radio' name='selection' value=" + optionNum + ">");

					var position = face["position"];

					var center_x = position["center"]["x"] / 100.0;
					var center_y = position["center"]["y"] / 100.0;
					var width = position["width"] / 100.0;
					var height = position["height"] / 100.0;

					var img = document.getElementById('map');
					var img_width = img.clientWidth;
					var img_height = img.clientHeight;

					var x1 = (img_width * center_x) - (img_width * width / 2);
					var y1 = (img_height * center_y)
							- (img_height * height / 2);
					var x2 = (img_width * center_x) + (img_width * width / 2);
					var y2 = (img_height * center_y)
							+ (img_height * height / 2);

					var posHtml = "<map name='face'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";

					$("#quizDIV").append(posHtml);

					$(function() {
						$('.map').maphilight();
					});

				}
				
				$("#inputDIV")
				.append(
						"<input type='hidden' id='person_id' value='" + personId + "'>" +
						"<div class='col-lg-3'><input type='text' class='form-control' placeholder='이름' id='person_name'></div>" +
						"<div class='col-lg-3 btn-group'>" +
						"<button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown' aria-expanded='false'>" +
						"관계 <span class='caret'></span>" +
						"</button>" +
						"<ul class='dropdown-menu' role='menu'>" +
						"<li><a href='#' onclick=\"validateInput2('본인', '" + personId + "')\">본인</a></li>" +
						"<li><a href='#' onclick=\"validateInput2('친구', '" + personId + "')\">친구</a></li>" +
						"<li><a href='#' onclick=\"validateInput2('회사동료', '" + personId + "')\">회사동료</a></li>" +
						"<li><a href='#' onclick=\"validateInput2('가족', '" + personId + "')\">가족</a></li>" +
						"<li><a href='#' onclick=\"validateInput2('애인', '" + personId + "')\">애인</a></li>" +
						"</ul>" +
						"</div>" );
				
				personIdx = personIdx + 1;
				
			} else {
				$("#nextDIV").html("");
				getQuizList();
			}
		}

		function generateQuiz() {
			$.ajax({
				type : "GET",
				url : "api/generate_quiz",
				dataType : "json",
				success : reqGenQuizResponse,
				error : errorResponse,
				beforeSend : generatingReponse
			});
		}

		function generatingReponse() {
			$("#quizForImgDIV").html("");
			$("#nextDIV").html("");
			
			$("#pageTitleDIV").html("<h3>퀴즈 생성</h3>");
			$("#quizDIV").html("퀴즈 생성 중");
			$("#inputDIV").html(
					"<p><img src='resources/image/loader-larger.gif' width=100/></p>" +
					"<div class=\"col-md-4 col-md-offset-4 alert alert-info\" role=\"alert\">사용자에게 개인화 된 퀴즈를 생성 중입니다.</div>" );
		}

		function reqGenQuizResponse(data) {
			var quizCnt = data["quizCnt"];
			if (quizCnt > 0) {
				getQuizList();
			} else {
				$("#quizForImgDIV").html("");
				$("#nextDIV").html("");
				
				$("#pageTitleDIV").html("<h3>퀴즈 생성</h3>");
				$("#quizDIV").html("퀴즈 생성 중");
				$("#inputDIV").html(
						"<p><img src='resources/image/loader-larger.gif' width=100/></p>" +
						"<div class=\"alert alert-info\" role=\"alert\">" +
						"퀴즈를 생성 하는데 실패 하였습니다. <br/> 사진을 업로드 하지 않으셨나요? 사진 분석 은 새벽 4시에 진행됩니다.</div>" );
			}
		}

		function getQuizList() {
			$.ajax({
				type : "GET",
				url : "api/get_quiz",
				dataType : "json",
				success : reqGetQuizResponse,
				error : errorResponse
			});
		}

		function reqGetQuizResponse(data) {
			quizList = data["quiz"];
			
			if (quizList.length > 0) {
				getQuiz();
			} else {
				generateQuiz();
			}
				
		}

		function getQuiz() {
			
			$("#quizDIV").html("");
			$("#quizForImgDIV").html("");
			$("#inputDIV").html("");
			$("#nextDIV").html("");
			$("#pageTitleDIV").html("<h3>퀴즈 풀이</h3>");
			
			if (quizIdx < quizList.length) {
				var quiz = quizList[quizIdx];
				var quizId = quiz["quiz_id"];

				var quiz_info = quiz["quiz_info"];
				var quiz_text = quiz_info["quiz_text"];
				var quiz_image = quiz_info["quiz_image"];

				var answer = quiz["answer"];

				$("#quizDIV").html(quiz_text + "<br>");
				if (quiz_image != null) {
					
					$("#inputDIV").append("<div id='quizForImgDIV' class='panel-body center-block text-center'></div>");
										
					$("#quizForImgDIV").append("<div class='col-md-3 col-md-offset-4'><div class='thumbnail' id ='quizImgThumb'></div></div>");
					var div_width = $("#quizImgThumb").width();
					var div_height = $("#quizImgThumb").height();
					
					if (div_width == 0) {
						div_width = div_height;
					}
					
					if (div_height == 0) {
						div_height = div_width;
					}
					
					$("#quizImgThumb").append("<img class='map' id='map' usemap='#face' src='" + quiz_image + "' width=" + div_width + " height=" + div_height + ">");// +"<input type='radio' name='selection' value=" + optionNum + ">");
					
					var position = quiz_info["position"];

					var center_x = position["center_x"] / 100.0;
					var center_y = position["center_y"] / 100.0;
					var width = position["width"] / 100.0;
					var height = position["height"] / 100.0;

					var img = document.getElementById('map');
					var img_width = img.clientWidth;
					var img_height = img.clientHeight;

					var x1 = (div_width * center_x) - (div_width * width / 2);
					var y1 = (div_height * center_y)
							- (div_height * height / 2);
					var x2 = (div_width * center_x) + (div_width * width / 2);
					var y2 = (div_height * center_y)
							+ (div_height * height / 2);

					var posHtml = "<map name='face'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";

					$("#quizImgThumb").append(posHtml);

					$(function() {
						$('.map').maphilight();
					});

				}
				//$("#inputDIV").html("<input type='hidden' id='quiz_id' value='" + quizId + "'>");

				//$("#inputDIV").append("<div class='btn-group' role='group' id='selectionDIV'></div>");
				$("#inputDIV").append("<nav><ul class='pager' id='selectionUL'></ul></nav>");
				
				var selections = quiz["selections"];
				for (var i = 0; i < selections.length; i++) {
					var selection = selections[i];
					var option = selection["selection"];
					var optionNum = selection["number"];
					var type = selection["type"];

					var optionHtml = "";
								
					if (type == "image") {
							$("#inputDIV").append("<div class='col-md-3'><a href='#' onclick='validateAnswer2(" + quizId + ", " + optionNum + ", " + answer + ")'><div class='thumbnail' id ='optionThumb_" + i +"'></div></a></div>");
							var div_width = $("#optionThumb_" + i).width();
							var div_height = $("#optionThumb_" + i).height();
							
							if (div_width == 0) {
								div_width = div_height;
							}
							
							if (div_height == 0) {
								div_height = div_width;
							}
							
							$("#optionThumb_" + i).append("<img class='map' id='selImg_" + i + "' usemap='#faceSel_" + i + "' src='" + option + "' width=" + div_width + " height=" + div_height + ">");// +"<input type='radio' name='selection' value=" + optionNum + ">");
							
							var position = selection["position"];
	
							if (position != null) {
	
								var center_x = position["center_x"] / 100.0;
								var center_y = position["center_y"] / 100.0;
								var width = position["width"] / 100.0;
								var height = position["height"] / 100.0;
	
								var img = document.getElementById('selImg_' + i);
								var img_width = img.clientWidth;
								var img_height = img.clientHeight;
	
								var x1 = (div_width * center_x)
										- (div_width * width / 2);
								var y1 = (div_height * center_y)
										- (div_height * height / 2);
								var x2 = (div_width * center_x)
										+ (div_width * width / 2);
								var y2 = (div_height * center_y)
										+ (div_height * height / 2);
	
								var posHtml = "<map name='faceSel_" + i + "'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";
	
								$("#optionThumb_" + i).append(posHtml);
								
								$(function() {
									$('.map').maphilight();
								});
							}

					} else {
						if (option != null) {
							optionHtml = option;
							$("#selectionUL").append("<li><a href='#' class='btn btn-default' role='button' onclick='validateAnswer2(" + quizId + ", " + optionNum + ", " + answer + ")'>" + optionHtml + "</a></li>");
							//$("#selectionDIV").append("<a href='#' class='btn btn-default' role='button' onclick='validateAnswer2(" + quizId + ", " + optionNum + ", " + answer + ")'>" + optionHtml + "</a>");
						}
					}
				}
				
				$(function() {
					$('.map').maphilight();
				});

				quizIdx = quizIdx + 1;

			} else {
				$("#quizDIV").html("모든 퀴즈를 풀었습니다. 수고하셨습니다.");
				$("#quizForImgDIV").html("");
				$("#inputDIV").html("");
				$("#nextDIV").html("");
			}
		}

		function validateAnswer2(quizId, optionNum, answer) {
			var selection = optionNum;

			if (selection) {
				if (selection == answer) {
					alert(selection + "을 선택했습니다. 정답입니다.");
				} else {
					alert(selection + "을 선택했습니다. 오답입니다.");
				}
				updateQuizInfo(quizId, selection);
				return true;
			} else {
				alert("정답을 선택하세요");
				return false;
			}
		}
		
		function validateAnswer(quizId, answer) {
			var selection = $(':input[name=selection]:radio:checked').val();

			if (selection) {
				if (selection == answer) {
					alert(selection + "을 선택했습니다. 정답입니다.");
				} else {
					alert(selection + "을 선택했습니다. 오답입니다.");
				}
				updateQuizInfo(quizId, selection);
				return true;
			} else {
				alert("정답을 선택하세요");
				return false;
			}
		}

		function validateInput2(personRelation, personId) {
			var personName = $("#person_name").val();
			if (personName.length > 0 && personRelation.length > 0) {
				updatePersonInfo(personName, personRelation, personId);
			} else {
				alert("사진속 인물의 이름과 본인과의 관계를 입력해주세요.");
			}
		}
		
		function validateInput() {
			var personName = $("#person_name").val();
			var personRelation = $("#person_relation").val();
			var personId = $("#person_id").val();
			if (personName.length > 0 && personRelation.length > 0) {
				updatePersonInfo(personName, personRelation, personId);
			} else {
				alert("사진속 인물의 이름과 본인과의 관계를 입력해주세요.");
			}
		}

		function updateQuizInfo(quizId, solved) {
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "api/update_quiz",
				data : {
					quiz_id : quizId,
					solved : solved,
				},
				success : reqQuizPostResponse,
				error : errorResponse
			});
		}

		function reqQuizPostResponse(data) {
			if (data["code"] == 1) {
				getQuiz();
			} else {
				alert(data["msg"]);
			}
		}

		function updatePersonInfo(personName, personRelation, personId) {
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "api/update_person",
				data : {
					person_id : personId,
					person_name : personName,
					relation : personRelation
				},
				success : reqPostResponse,
				error : errorResponse
			});
		}

		function reqPostResponse(data) {
			if (data["code"] == 1) {
				getPerson();
			} else {
				alert(data["msg"]);
			}
		}

		function getNewPersonList() {
			$.ajax({
				type : "GET",
				url : "api/new_persons",
				dataType : "json",
				success : reqGetResponse,
				error : errorResponse
			});
		}

		function reqGetResponse(data) {
			personList = data["persons"];
			getPerson();
		}

		function errorResponse() {
			alert("Request Error");
		}

		$(document).ready(getNewPersonList());
	</script>

</body>
</html>