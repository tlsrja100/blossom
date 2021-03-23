<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp"%>
<link rel="stylesheet" href="/resources/css/reviewInsert.css">
<script src="/resources/js/review_file_upload.js?=ver13"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="wrap">
		<form action="/review/reviewInsert" method="post" id="reviewForm" role="form" enctype="multipart/form-data"  > 
			<div class="mb-3">	
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요."/>
			</div>
			<div class="mb-3">
				<label for="writer">작성자</label>
				<input type="text" class="form-control" name="writer" id="writer" readonly value="${login.name }"/><!-- value="${login.name}"; -->
			</div>
			<div class="mb-3">
				<label for="content">글내용</label> 
				<textarea class="form-control" rows="4" name="content" id="content" placeholder="내용을 입력해주세요." ></textarea>
			</div>

			<!-- 이미지 업로드 구간 시작 -->
			<div class="panel panel-default">
				<div class="panel-heading">사진업로드 </div>
				<div class="panel-body">
					<div class="fileDrop" >
						<ul>
							<!-- 이미지 썸네일 보여지는 곳 -->
						</ul>
					</div>
					<div class="file_div">
						<div class="file_Btn" >
							<input type="file" name="uploadFile" /><br />
							 <span style="text-size:12px; color:red">* 제일 처음 등록한 사진이 썸네일이 됩니다.</span>
						</div>
					
						<div class="file_Upload">
							<button type="button" class="btn btn-primary btn-clock" id="uploadImg">사진등록</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 이미지 업로드 구간 끝 -->
			<div class="submitBtn">
				<button type="submit" class="btn btn-success" >등록</button>
			</div>
		</form>
	</div>
</body>

</html>