<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

		<title>Upload Images</title>

		<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		
		<!-- Modernizer -->
		<!-- <script src="resources/dropper/modernizr.js"></script> -->
		
		<!-- Demo Resources -->
		<!-- <link href="resources/dropper/css/demo.css" rel="stylesheet" type="text/css" media="all"> -->
		<!-- <script src="resources/dropper/demo.js"></script> -->
		
		<!--[if IE 8]>
        	<script>var IE8 = true;</script>
        	<script src="http://formstone.it/js/site.ie8.js"></script>
			<link rel="stylesheet" href="http://formstone.it/css/demo.ie8.css">
		<![endif]-->
		<!--[if IE 9]>
        	<script>var IE9 = true;</script>
        	<script src="http://formstone.it/js/site.ie9.js"></script>
		<![endif]-->

		<link href="resources/dropper/css/jquery.fs.dropper.css" rel="stylesheet" type="text/css" media="all">
		<script src="resources/dropper/js/jquery.fs.dropper.js"></script>

		<!--[DEMO:START-RESOURCES]-->

		<style>
			.demo .filelists { margin: 20px 0; }
			.demo .filelists h5 { margin: 10px 0 0; }
			.demo .filelist { margin: 0; padding: 10px 0; }
			.demo .filelist li { background: #fff; border-bottom: 1px solid #eee; font-size: 14px; list-style: none; padding: 5px; }
			.demo .filelist li:before { display: none; }
			.demo .filelist li .file { color: #333; }
			.demo .filelist li .progress { color: #666; float: right; font-size: 10px; text-transform: uppercase; }
			.demo .filelist li .delete { color: red; cursor: pointer; float: right; font-size: 10px; text-transform: uppercase; }
			.demo .filelist li.complete .progress { color: green; }
			.demo .filelist li.error .progress { color: red; }
		</style>

		<script>
			var $filequeue,
				$filelist;
			$(document).ready(function() {
				$filequeue = $(".demo .filelist.queue");
				$filelist = $(".demo .filelist.complete");
				$(".demo .dropped").dropper({
					action: "upload",
					maxSize: 5242880
				}).on("start.dropper", onStart)
				  .on("complete.dropper", onComplete)
				  .on("fileStart.dropper", onFileStart)
				  .on("fileProgress.dropper", onFileProgress)
				  .on("fileComplete.dropper", onFileComplete)
				  .on("fileError.dropper", onFileError);
				$(window).one("pronto.load", function() {
					$(".demo .dropped").dropper("destroy").off(".dropper");
				});
			});
			function onStart(e, files) {
				console.log("Start");
				var html = '';
				for (var i = 0; i < files.length; i++) {
					html += '<li data-index="' + files[i].index + '"><span class="file">' + files[i].name + '</span><span class="progress">Queued</span></li>';
				}
				$filequeue.append(html);
			}
			function onComplete(e) {
				console.log("Complete");
				// All done!
			}
			function onFileStart(e, file) {
				console.log("File Start");
				$filequeue.find("li[data-index=" + file.index + "]")
						  .find(".progress").text("0%");
			}
			function onFileProgress(e, file, percent) {
				console.log("File Progress");
				$filequeue.find("li[data-index=" + file.index + "]")
						  .find(".progress").text(percent + "%");
			}
			function onFileComplete(e, file, response) {
				console.log("File Complete");
				if (response.length > 0) {
					var $target = $filequeue.find("li[data-index=" + file.index + "]");
					$target.find(".file").text(file.name);
					$target.find(".progress").remove();
					$target.appendTo($filelist);
				} else {
					$filequeue.find("li[data-index=" + file.index + "]").addClass("error")
							  .find(".progress").text("Error");
				}
			}
			function onFileError(e, file, error) {
				console.log("File Error");
				$filequeue.find("li[data-index=" + file.index + "]").addClass("error")
						  .find(".progress").text("Error: " + error);
			}
		</script>

		<!--[DEMO:END-RESOURCES]-->

		<!-- Bootstrap -->
		<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		    <![endif]-->
		<!-- 

		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script src="resources/maphilight/jquery.maphilight.js"></script>
		
		<!-- END BOOTSTRAP -->

	</head>

	<body class="gridlock demo">
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
					<li class="active"><a href="uploader">Upload<span class="sr-only">(current)</span></a></li>
					<li><a href="quiz">Quiz</a></li>					
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
			<div class="page-header" id="pageTitleDIV"><h3>사진 업로드</h3></div>
			
			<div class="alert alert-warning" role="alert">
			<p>
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			  <span class="sr-only"></span>
			  이미지가 정방향으로 촬영 되었는지 확인해주세요. 사진이 정방향이 아닐 경우 분석이 되지 않습니다.
			 </p>
			 <p>
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			  <span class="sr-only"></span>
			  이미지는 익일 새벽 2시에 분석되며, 분석이 완료 된 후에 퀴즈 서비스를 사용하 실 수 있습니다.
			 </p>
			</div>
			
			<div class="panel panel-primary">
			
				<div id="quizDIV" class="panel-heading">촬영된 일상의 사진을 업로드 해주세요.</div>
				<div id="inputDIV" class="panel-body">
				
			<article class="row page">
			<div class="mobile-full tablet-full desktop-8 desktop-push-2 col-md-8 col-md-offset-2">

				<!--[DEMO:START-CONTENT]-->

				<form action="#" class="demo_form">
					<div class="dropped"></div>

					<div class="filelists">
						<div class="page-header"><h5>완료된 목록</h5></div>
						<ol class="filelist complete">
						</ol>
						<div class="page-header"><h5>진행중 목록</h5></div>
						<ol class="filelist queue">
						</ol>
					</div>
				</form>

				<!--[DEMO:END-CONTENT]-->

			</div>
		</article>
				
				</div>
			
			</div>
			
			<div id="nextDIV"></div>
		</div>
	

	</div> <!-- end container -->
	</body>
</html>