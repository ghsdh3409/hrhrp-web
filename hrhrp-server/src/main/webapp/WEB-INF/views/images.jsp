<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

		<title>Upload Images</title>

		<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

		<!-- Modernizer -->
		<!-- <script src="resources/dropper/modernizr.js"></script> -->
		
		<!-- Demo Resources -->
		<link href="resources/dropper/css/demo.css" rel="stylesheet" type="text/css" media="all">
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
					maxSize: 1048576
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

	</head>

	<body class="gridlock demo">
			<article class="row page">
			<div class="mobile-full tablet-full desktop-8 desktop-push-2">
				<header class="header">
					<h1>Upload Images</h1>
					<br>
				</header>

				<!--[DEMO:START-CONTENT]-->

				<form action="#" class="demo_form">
					<div class="dropped"></div>

					<div class="filelists">
						<h5>Complete</h5>
						<ol class="filelist complete">
						</ol>
						<h5>Queued</h5>
						<ol class="filelist queue">
						</ol>
					</div>
				</form>

				<!--[DEMO:END-CONTENT]-->

			</div>
		</article>

	</body>
</html>