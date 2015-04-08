<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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

		<div id="progressTextDIV" class="alert alert-warning" role="alert" style="display:none;">
		</div>

		<div id="warningDIV" class="alert alert-warning" role="alert" style="display:none;">
		</div>
		
		<div id="pregressDIV" class="progress" style="display:none;">
		  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
		    <span class="sr-only">100% Complete</span>
		  </div>
		</div>

		<div id="quizContainer" class="container">
			<div id="infoDIV"></div>
			<div class="page-header" id="pageTitleDIV"></div>
			<div class="panel panel-primary">
	
				<div id="quizDIV" class="panel-heading"></div>
				<div id="bodyDIV" class="panel-body">
					<div id="inputDIV" class="row centered text-center"></div>
					<div id="selectionDIV"></div>
				</div>
				
			</div>
			<div id="resultDIV"></div>				
			<div id="nextDIV"></div>
					
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
		var quizIdx = -1;

		function getPerson() {
			if (personIdx < personList.length) {
				
				$("#quizDIV").html("");
				$("#quizForImgDIV").html("");
				$("#inputDIV").html("");
				$("#selectionDIV").html("");
				$("#nextDIV").html("");
				$("#pageTitleDIV").html("<h3>새롭게 발견된 사람 정보 입력</h3>");
				
				var person = personList[personIdx];
				var personId = person["person_id"];
				var personName = person["person_name"];
				var photoId = null;
				var faceId =null;
				
				var faces = person["faces"];

				$("#quizDIV").html("다음사람의 이름과 본인과의 관계는 무엇입니까?" + "<br>");
				
				for (var i = 0; i < faces.length; i++) {
					if (i > 0) {
						break;
					}
					var face = faces[i];
					var url = face["url"];
					photoId = url;
					faceId = face["face_id"];
					
					//$("#inputDIV").append("<div id='quizForImgDIV' class='panel-body center-block text-center'></div>");
					$("#inputDIV").append("<div class='col-md-4 col-md-offset-4'><div class='thumbnail' id ='quizForImgDIV_" + i +"'></div></div>");
					
					//$("#quizForImgDIV").append("<div class='col-md-4'><div class='thumbnail' id ='quizImgThumb'></div></div>");
					var div_width = $("#quizForImgDIV_" + i).width();
					var div_height = $("#quizForImgDIV_" + i).height();
					
					if (div_width == 0) {
						div_width = div_height;
					}
					
					if (div_height == 0) {
						div_height = div_width;
					}
					
					$("#quizForImgDIV_" + i).append("<img class='map' id='selImg_" + i + "' usemap='#faceSel_" + i + "' src='" + url + "' width=" + div_width + " height=" + div_width + ">");// +"<input type='radio' name='selection' value=" + optionNum + ">");

					var position = face["position"];

					var center_x = position["center"]["x"] / 100.0;
					var center_y = position["center"]["y"] / 100.0;
					var width = position["width"] / 100.0;
					var height = position["height"] / 100.0;

					var img = $("#selImg_" + i);
					var img_width = img.attr('width');
					var img_height = img.attr('height');
					
					var x1 = (img_width * center_x) - (img_width * width / 2);
					var y1 = (img_height * center_y)
							- (img_height * height / 2);
					var x2 = (img_width * center_x) + (img_width * width / 2);
					var y2 = (img_height * center_y)
							+ (img_height * height / 2);

					var posHtml = "<map name='faceSel_" + i + "'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";

					$("#quizForImgDIV_" + i).append(posHtml);

					$(function() {
						$('.map').maphilight();
					});

				}
				
				$(function() {
					$('.map').maphilight();
				});
				
				var personNameHtml = "";
				if (personName != null) {
					personNameHtml = "value='" +personName + "'";
				}
				
				$("#inputDIV").append("<div id='quizInputDIV' class='panel-body center-block text-center'></div>");
				
				$("#quizInputDIV")
				.append("<div class='row'>" +
						"<div class='col-lg-4 col-lg-offset-4'>" +
						"<div class='input-group'>" +
						"<input type='hidden' id='person_id' value='" + personId + "'>" +
						"<input type='text' class='form-control' placeholder='이름' id='person_name'" + personNameHtml + ">" +
						"<div class='input-group-btn'>" +
						"<button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown' aria-expanded='false'>" +
						"관계 <span class='caret'></span>" +
						"</button>" +
						"<ul class='dropdown-menu' role='menu'>" +
						"<li><a href='#' onclick=\"validateInput('본인', '" + personId + "', '" + photoId + "', '" + faceId + "'" + ")\">본인</a></li>" +
						"<li><a href='#' onclick=\"validateInput('친구', '" + personId + "', '" + photoId + "', '" + faceId + "'" + ")\">친구</a></li>" +
						"<li><a href='#' onclick=\"validateInput('회사동료', '" + personId + "', '" + photoId + "', '" + faceId + "'" + ")\">회사동료</a></li>" +
						"<li><a href='#' onclick=\"validateInput('가족', '" + personId + "', '" + photoId + "', '" + faceId + "'" + ")\">가족</a></li>" +
						"<li><a href='#' onclick=\"validateInput('애인', '" + personId + "', '" + photoId + "', '" + faceId + "'" + ")\">애인</a></li>" +
						"<li><a href='#' onclick=\"validateInput('교수님', '" + personId + "', '" + photoId + "', '" + faceId + "'" + ")\">교수님</a></li>" +
						"</ul>" +
						"</div></div></div> <!-- /.col-lg-6 -->" +
						"</div> <!-- /.row --> ");
				
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
						"<div class=\"alert alert-warning\" role=\"alert\">" +
						"생성된 퀴즈가 없습니다. <br/> 사진을 업로드 하지 않았거나, 아직 분석 중일 수 있습니다.</div>" );
			}
		}

		function getQuizResult() {
			$.ajax({
				type : "GET",
				url : "api/get_quiz_result",
				dataType : "json",
				success : reqGetQuizResultResponse,
				error : errorResponse
			});
		}
		
		function reqGetQuizResultResponse(data) {
			quizResultList = data["quiz"];
			if (quizResultList.length > 0) {
				$("#resultDIV").html(
						"<div class=\"panel panel-default\">" +
				  			"<div class=\"panel-heading\">퀴즈 풀이 결과</div>" +
				  				"<table id=\"quizResultTable\" class=\"table\">" +
				  				"<tr id=\"quizResultTableQuizRow\"><td>문제</td></tr>" +
				  				"<tr id=\"quizResultTableAnswerRow\"><td>정답</td></tr>" +
							"</table></div>");
				
				for (var i=0; i<quizResultList.length; i++) {
					quizResult = quizResultList[i];
					var answer = quizResult["answer"];
					var solved = quizResult["solved"];
					
					$("#quizResultTableQuizRow").append("<td>" + (i + 1) + "</td>");
					if (solved == 0){
						$("#quizResultTableAnswerRow").append("<td>" + "&nbsp;" + "</td>");
					} else if (answer == solved) {
						$("#quizResultTableAnswerRow").append("<td>" + "O" + "</td>");
					} else {
						$("#quizResultTableAnswerRow").append("<td>" + "X" + "</td>");
					}
				}
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
			$("#selectionDIV").html("");
			$("#nextDIV").html("");
			$("#pageTitleDIV").html("<h3>퀴즈 풀이</h3>");
			
			quizIdx = quizIdx + 1;
			getQuizResult();
						
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
										
					$("#quizForImgDIV").append("<div class='col-md-4 col-md-offset-4'><div class='thumbnail' id ='quizImgThumb'></div></div>");
					var div_width = $("#quizImgThumb").width();
					var div_height = $("#quizImgThumb").height();
					
					if (div_width == 0) {
						div_width = div_height;
					}
					
					if (div_height == 0) {
						div_height = div_width;
					}
					
					$("#quizImgThumb").append("<img class='map' id='map' usemap='#face' src='" + quiz_image + "' width=" + div_width + " height=" + div_width + ">");// +"<input type='radio' name='selection' value=" + optionNum + ">");
					
					var position = quiz_info["position"];

					var center_x = position["center_x"] / 100.0;
					var center_y = position["center_y"] / 100.0;
					var width = position["width"] / 100.0;
					var height = position["height"] / 100.0;

					var img = $("#selImg_" + i);
					var img_width = img.attr('width');
					var img_height = img.attr('height');

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
							$("#inputDIV").append("<div class='col-md-3'><div class='thumbnail' id ='optionThumb_" + i +"'></div></div>");
							var div_width = $("#optionThumb_" + i).width();
							var div_height = $("#optionThumb_" + i).height();
							
							if (div_width == 0) {
								div_width = div_height;
							}
							
							if (div_height == 0) {
								div_height = div_width;
							}
							
							$("#optionThumb_" + i).append("<img class='map' id='selImg_" + i + "' usemap='#faceSel_" + i + "' src='" + option + "' width=" + div_width + " height=" + div_height + ">");
							$("#optionThumb_" + i).append("<div class='caption'><a id='selection_btn_" + optionNum + "' href='#' class='btn btn-default btn-block selection_btn' role='button' onclick='validateAnswer(" + quizId + ", " + optionNum + ", " + answer + ")'>" + "선택" + "</a></div>");
							
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
							$("#selectionUL").append("<li><a id='selection_btn_" + optionNum + "' href='#' class='btn btn-default selection_btn' role='button' onclick='validateAnswer(" + quizId + ", " + optionNum + ", " + answer + ")'>" + optionHtml + "</a></li>");
						}
					}
				}
					
				$(function() {
					$('.map').maphilight();
				});

			} else {
				$("#quizDIV").html("모든 퀴즈를 풀었습니다. 수고하셨습니다.");
				$("#quizForImgDIV").html("");
				$("#inputDIV").html("");
				$("#nextDIV").html("");
				$("#selectionDIV").html("");
			}
		}

		function validateAnswer(quizId, optionNum, answer) {
			var selection = optionNum;
			$("#selectionDIV").html("");
			$(".selection_btn").addClass('disabled');
			if (selection == answer) {
				$("#selection_btn_" + selection).addClass('btn-primary');
				$("#selectionDIV").append("<a href='#' onclick=\"updateQuizInfo(" + quizId + ", " + selection + ")\"><div id=\"answerCorrectDIV\" class=\"alert alert-success\" role=\"alert\"><div class='row'><div class='col-xs-6'><span class='glyphicon glyphicon-ok' aria-hidden='true'></span><strong> 정답입니다!</strong></div><div class='col-xs-6 text-right'><strong>다음</strong><span class='glyphicon glyphicon-menu-right' aria-hidden='true'></span></div></div></div></a>");
			} else {
				//$("#selection_btn_" + answer).addClass('btn-primary');
				$("#selection_btn_" + selection).addClass('btn-danger');
				$("#selectionDIV").append("<a href='#' onclick=\"updateQuizInfo(" + quizId + ", " + selection + ")\"><div id=\"answerIncorrectDIV\" class=\"alert alert-danger\" role=\"alert\"><div class='row'><div class='col-xs-6'><span class='glyphicon glyphicon-remove' aria-hidden='true'></span><strong> 오답입니다!</strong></div><div class='col-xs-6 text-right'><strong>다음</strong><span class='glyphicon glyphicon-menu-right' aria-hidden='true'></span></div></div></div></a>");
			}
			return true;
		}

		function validateInput(personRelation, personId, photoId, faceId) {
			var personName = $("#person_name").val();
			if (personName.length > 0 && personRelation.length > 0) {
				$("#warningDIV").hide();
				updatePersonInfo(personName, personRelation, personId, photoId, faceId);
			} else {
				$("#warningDIV").html("사진속 인물의 이름과 본인과의 관계를 입력해주세요.");
				$("#warningDIV").show();
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

		function updatePersonInfo(personName, personRelation, personId, photoId, faceId) {
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "api/update_person",
				data : {
					person_id : personId,
					person_name : personName,
					relation : personRelation,
					photo_id : photoId,
					face_id : faceId
				},
				success : reqPostResponse,
				error : errorResponse,
				beforeSend : showProgressBar,
				complete : closeProgressBar
			});
		}

		function showProgressBar() {
			$("#pregressDIV").show();
			$("#progressTextDIV").html("처리 중 입니다. 잠시만 기다려 주세요.");
			$("#progressTextDIV").show();
		}
		
		function closeProgressBar() {
			$("#pregressDIV").hide();
			$("#progressTextDIV").hide();
		}
		
		function reqPostResponse(data) {
			if (data["code"] == 1) {
				getPerson();
			} else {
				$("#warningDIV").html("요청 실패! 다시 시도해주세요. <br/>" + data["msg"]);
				$("#warningDIV").show();
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

		function errorResponse(xhr,err) {
			$("#warningDIV").html("요청 실패! 다시 시도해주세요. <br/>" + xhr.responseText);
			$("#warningDIV").show();
		}

		$(document).ready(getNewPersonList());
	</script>

</body>
</html>