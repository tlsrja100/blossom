<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/resources/js/review_file_upload.js"></script>
<!-- <script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<script src="/resources/js/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css"> -->
<style>
.container{
 padding-top: 70px;
 padding-bottom: 30px;
}
.mb-3 {
	padding-top : 20px;
}

.fileDrop {
	width: 77%;
	height: 200px;
	border: 1px dotted blue;
	float:left;
}
#img_px {
	width: 150px;
	height:200px;
}
#image_span {
	float:left;
	margin-right:10px;
}
</style>
<body>
<article>
	<div class="container">
		<form id="reviewForm" action="/review/reviewInsert" method="post" role="form" enctype="multipart/form-data"  > <!-- action="/review/reviewInsert" method="post" -->
			<div class="mb-3">	
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요."/>
			</div>
			<div class="mb-3">
				<label for="writer">작성자</label>
				<input type="text" class="form-control" name="writer" id="writer" readonly value="${login.name}" /><!-- value="${login.name}"; -->
			</div>
			<div class="mb-3">
				<label for="content">글내용</label> 
				<textarea class="form-control" rows="4" name="content" id="content" placeholder="내용을 입력해주세요." ></textarea>
				<!-- <textarea id="summernote" name="content"></textarea> -->
			</div>
			<!-- 이미지 업로드 구간 시작 -->
			<div>
				<br />
				<div class="fileDrop" >
				</div>
				<div style="width:20%;float:right">
					<input type="file" name="uploadFile" multiple="multiple"/>
					<br />
					<button type="button" class="btn btn-primary btn-clock" style="width:76px;" id="uploadImg">사진등록</button>
				</div>
			</div>
			<button type="submit" style="margin-top:130px; margin-left:40px;" class="btn btn-success">등록</button>
		</form>
	</div>
</article>
</body>

</html>