<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>

<script type="text/javascript">

	//TODO : email check
	//TODO : overlap check

	function formCheck() {
		

		
		var email = document.getElementById('email');
		var password = document.getElementById('password');
		var name = document.getElementById('name');
	
		if (email.value == '' || email.value == null) {
			alert('Please input the email');
			focus.member_id;
			return false;
		}

		if (password.value == '' || password.value == null) {
			alert('Please input the password');
			focus.password;
			return false;
		}
		
		if (name.value == '' || name.value == null) {
			alert('Please input the name');
			focus.password;
			return false;
		}
		
		save();	
		return true;
	}
	
		
	function save() {
		var joinForm = document.getElementById('join');
		joinForm.submit();
	}
	
</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Register</title>
</head>
<body>

	<form action="/kaist/api/signup" method="post" id="join">
		<input type="text" size="20" id="email" name="email" maxlength="100" placeholder="Email"> <br>
		<input type="password" id="password" name="password" size=20 maxlength="12" placeholder="Password"> <br>
		<input type="text" id="name" name="name" size=20 maxlength="12" placeholder="Name"> <br>
		<input type="button" id="join" name="join" value="Register" onclick="javascript:formCheck();">
	</form>
	
</body>
</html>