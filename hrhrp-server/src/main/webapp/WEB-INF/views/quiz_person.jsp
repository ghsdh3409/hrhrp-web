<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		var personIdx = 0;
		var personList = [];
		
		function getPerson() {
			if (personIdx < personList.length) {		
				var person = personList[personIdx];
				var personId = person["person_id"];
				
				var faces = person["faces"];

				for (var i=0; i<faces.length; i++) {
					var face = faces[i];
					var url = face["url"];
					$("#newPerson").html("<img src='" + url + "'>");
				}
				personIdx = personIdx + 1;
				if (personIdx <= personList.length) {
					$("#nextDIV").html("<a href='javascript:;' onclick='validateInput()'>다음</a>");
					$("#inputDIV").html("이름 <input type='text' id='person_name'>" + "관계 <input type='text' id='person_relation'>"
										+"<input type='hidden' id='person_id' value='" + personId + "'>");
				} else {
					$("#nextDIV").html("");
				}
			}
		}
		
		function validateInput() {
			var personName = $("#person_name").val();
			var personRelation = $("#person_relation").val();
			var personId = $("#person_id").val();
			if (personName.length > 0 && personRelation.length > 0) {
				alert(personName);
				alert(personRelation);
				alert(personId);
				updatePersonInfo(personName, personRelation, personId);
			} else {
				alert("사진속 인물의 이름과 본인과의 관계를 입력해주세요.");
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

<div id="newPerson"></div>
<div id="inputDIV"></div>
<div id="nextDIV"></div>
</body>
</html>