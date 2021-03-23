<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.wrap{
	width:800px;
	height:800px;
	margin:auto;
	margin-top : 60px;
}
.mb-3 {
	padding-top : 20px;
}
</style>
<body>
	<div class="wrap">
		<form id="insertForm">
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
				<textarea style="resize:none;height:300px;" class="form-control" rows="4" name="content" id="content" placeholder="내용을 입력해주세요." ></textarea>
			</div>
		</form>
		<br />
			<div>
				<button style="float:right" type="button" class="btn btn-primary" onclick="insertbtn()">등록</button>
			</div>
	</div>
</body>
<script>
function insertbtn() {
	var title = $("#title").val();
	var content = $("#content").val();
	if(title == ""){
		alert("제목을 입력해주세요");
		$("#title").focus();
		return;
	}
	if(content == ""){
		alert("내용을 입력해주세요");
		$("#content").focus();
		return;
	}
	var insert = confirm("글을 등록 하시겠습니까?");
	var insertForm = $("#insertForm").serialize();
	if(insert) {
		$.ajax({
			url : "/board/boardInsert",
			type : "post",
			data : insertForm,
			success : function(data){
				location.href = "/board/boardMain";
			}
		})
	}
}
</script>
</html>