<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
	<script	src="resources/maphilight/jquery.maphilight.js"></script>
	<script type="text/javascript">
		
		var personIdx = 0;
		var personList = [];
		var quizList = [];
		var quizIdx = 0;
		
		function getPerson() {
			if (personIdx < personList.length) {		
				var person = personList[personIdx];
				var personId = person["person_id"];
								
				var faces = person["faces"];

				$("#quizDIV").html("다음사람의 이름과 본인과의 관계는 무엇입니까?" + "<br>");
				
				for (var i=0; i<faces.length; i++) {
					var face = faces[i];
					var url = face["url"];

					$("#quizDIV").append("<img class='map' id='map' usemap='#face' src='" + url + "' width='250' height='250'><br>");
					
					var position = face["position"];
					
					var center_x = position["center"]["x"] / 100.0;
					var center_y = position["center"]["y"] / 100.0;
					var width = position["width"] / 100.0;
					var height = position["height"] / 100.0;
	
					var img = document.getElementById('map'); 
					var img_width = img.clientWidth;
					var img_height = img.clientHeight;
					
					var x1 = (img_width * center_x) - (img_width * width / 2);
					var y1 = (img_height * center_y) - (img_height * height / 2);
					var x2 = (img_width * center_x) + (img_width * width / 2);
					var y2 = (img_height * center_y) + (img_height * height / 2);
								
					var posHtml =
						"<map name='face'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";

						$("#quizDIV").append(posHtml);
						
						$(function() {
					        $('.map').maphilight();
					    });
					
				}
				personIdx = personIdx + 1;
				if (personIdx <= personList.length) {
					$("#nextDIV").html("<a href='javascript:;' onclick='validateInput()'>다음</a>");
					$("#inputDIV").html("이름 <input type='text' id='person_name'>" + "관계 <input type='text' id='person_relation'>"
										+"<input type='hidden' id='person_id' value='" + personId + "'>");
				} else {
					$("#nextDIV").html("");
				}
			} else {
				$("#nextDIV").html("");
				getQuizList();
			}
		}
		
		function getQuizList() {
			$.ajax({
				type : "GET",
				url	: "api/get_quiz",
				dataType : "json",
				success : reqGetQuizResponse,
				error : errorResponse
			});
		}
			
		function reqGetQuizResponse(data) {
			quizList = data["quiz"];
			getQuiz();
		}
				
		function getQuiz() {
			if (quizIdx < quizList.length) {		
				var quiz = quizList[quizIdx];
				var quizId = quiz["quiz_id"];
				
				var quiz_info = quiz["quiz_info"];		
				var quiz_text = quiz_info["quiz_text"];
				var quiz_image = quiz_info["quiz_image"];
				
				var answer = quiz["answer"];
				
				$("#quizDIV").html(quiz_text + "<br>");
				if (quiz_image != null) {
					$("#quizDIV").append("<img class='map' id='map' usemap='#face' src='" + quiz_image + "' width='250' height='250'><br>");
				
					var position = quiz_info["position"];
					
					var center_x = position["center_x"] / 100.0;
					var center_y = position["center_y"] / 100.0;
					var width = position["width"] / 100.0;
					var height = position["height"] / 100.0;
	
					var img = document.getElementById('map'); 
					var img_width = img.clientWidth;
					var img_height = img.clientHeight;
					
					var x1 = (img_width * center_x) - (img_width * width / 2);
					var y1 = (img_height * center_y) - (img_height * height / 2);
					var x2 = (img_width * center_x) + (img_width * width / 2);
					var y2 = (img_height * center_y) + (img_height * height / 2);
								
					var posHtml =
						"<map name='face'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";

						$("#quizDIV").append(posHtml);
						
						$(function() {
					        $('.map').maphilight();
					    });
						
				}
				$("#inputDIV").html("<input type='hidden' id='quiz_id' value='" + quizId + "'>");
				
				var selections = quiz["selections"];
				for (var i=0; i<selections.length; i++) {
					var selection = selections[i];
					var option = selection["selection"];
					var optionNum = selection["number"];
					var type = selection["type"];
					
					var optionHtml = "";					
					if (type == "image") {
						
						$("#inputDIV").append("<img class='map' id='selImg_" + i + "' usemap='#faceSel_" + i + "' src='" + option + "' width='250' height='250'>" );
						
						var position = selection["position"];
						
						if (position != null) {
						
							var center_x = position["center_x"] / 100.0;
							var center_y = position["center_y"] / 100.0;
							var width = position["width"] / 100.0;
							var height = position["height"] / 100.0;
											
							var img = document.getElementById('selImg_' + i); 
							var img_width = img.clientWidth;
							var img_height = img.clientHeight;
								
							var x1 = (img_width * center_x) - (img_width * width / 2);
							var y1 = (img_height * center_y) - (img_height * height / 2);
							var x2 = (img_width * center_x) + (img_width * width / 2);
							var y2 = (img_height * center_y) + (img_height * height / 2);
											
							var posHtml =
								"<map name='faceSel_" + i + "'> <area shape='rect' coords='" + x1 + "," + y1 + "," + x2 + "," + y2 + "' data-maphilight='{\"alwaysOn\":true}'> </map>";
	
							$("#inputDIV").append(posHtml);
									
							$(function() {
								$('.map').maphilight();
							});
						
						}
						
					} else {
						optionHtml = option;
					} 
														
					$("#inputDIV").append("<input type='radio' name='selection' value=" + optionNum + ">" + optionHtml);
				}
				
				quizIdx = quizIdx + 1;
				if (quizIdx <= quizList.length) {
					$("#nextDIV").html("<a href='javascript:;' onclick='validateAnswer(" + quizId + ", " + answer + ")'>다음</a>");
				} else {
					$("#nextDIV").html("");
				}
			} else {
				$("#quizDIV").html("모든 퀴즈를 풀었습니다. 수고하셨습니다.");
				$("#inputDIV").html("");
				$("#nextDIV").html("");
			}
		}
		
		function validateAnswer(quizId, answer) {
			var selection = $(':input[name=selection]:radio:checked').val();
			
			if( selection ) {
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
				 type: "POST", 
				 dataType: "json",
				 url: "api/update_quiz",
				 data: {
					 quiz_id:quizId,
					 solved:solved,
					 },
				 success: reqQuizPostResponse,
				 error: errorResponse
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
				 type: "POST", 
				 dataType: "json",
				 url: "api/update_person",
				 data: {
					 person_id:personId,
					 person_name:personName,
					 relation:personRelation
					 },
				 success: reqPostResponse,
				 error: errorResponse
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
				url	: "api/new_persons",
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


	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
</head>
<body>

<div id="quizDIV"></div>
<div id="inputDIV"></div>
<div id="nextDIV"></div>
</body>
</html>