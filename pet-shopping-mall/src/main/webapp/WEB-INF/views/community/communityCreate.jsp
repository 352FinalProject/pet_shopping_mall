<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="${pageContext.request.contextPath}/resources/js/summernote-ko-KR.js"></script>

<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR'
		});
	});
</script>
</head>
<body>
	<h2 style="text-align: center;">글 작성</h2>
	<br>
	<br>
	<br>

	<div style="width: 60%; margin: auto;">
		<form method="post" action="/write">
			<input type="text" name="writer" style="width: 20%;" placeholder="작성자" /><br> <input type="text" name="title" style="width: 40%;" placeholder="제목" />

			<!-- 파일 업로드 시작 -->
			
			<br><br>
			<div class="row" id="fileContainer">
				<div class="file-field input-field col s12">
					<div class="btn">
						<span><i class="material-icons left"></i></span> <input type="file" name="files" multiple>
					</div>
					<div class="file-path-wrapper">
						<br>
					</div>
					<span class="helper-text">첨부파일로 업로드 가능한 용량은 최대 50MB 입니다.</span>
				</div>
			</div>

			<!--  파일 업로드 끝 -->

			<br>
			<br>
			<textarea id="summernote" name="content"></textarea>
			<input id="subBtn" type="button" value="글 작성" style="float: right;" onclick="goWrite(this.form)" />
		</form>
	</div>

</body>
</html>