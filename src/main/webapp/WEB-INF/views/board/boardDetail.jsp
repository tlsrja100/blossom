<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../include/header.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container{
	 padding-bottom: 30px;
}
.mb-3 {
	padding-top : 20px;
}
</style>
<body>
<article>
	<div class="container" style="width:800px;">
		<c:choose>
			<c:when test="${login.grade == 9}">
			<form id="modifyForm">
				<input type="hidden" name="num" id="num" value="${boardDto.num}" />
				<div class="mb-3">	
					<label for="title">제목</label>
					<input type="text" class="form-control" name="title" id="title" value="${boardDto.title}"/>
				</div>
				<div class="mb-3">
					<label for="writer">작성자</label>
					<input type="text" class="form-control" name="writer" id="writer" readonly value="${boardDto.writer}" /><!-- value="${login.name}"; -->
				</div>
				<div class="mb-3">
					<label for="writer">작성일</label>
					<input type="text" class="form-control" name="regdate" id="regdate" readonly value="${boardDto.regdate}" /><!-- value="${login.name}"; -->
				</div>
				<div class="mb-3">
					<label for="content">글내용</label>
					<textarea class="form-control" rows="4" name="content" id="content">${boardDto.content }</textarea>
				</div>
				<br />
				<div>
					<button type="button" class="btn btn-primary" onclick="modify()">수정</button>
					<button type="button" class="btn btn-primary" onclick="del()">삭제</button>
				</div>
			</form>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="num" id="id" value="${boardDto.num}"/>
				<div class="mb-3">	
					<label for="title">제목</label>
					<input type="text" class="form-control" name="title" id="title" readonly value="${boardDto.title}"/>
				</div>
				<div class="mb-3">
					<label for="writer">작성자</label>
					<input type="text" class="form-control" name="writer" id="writer" readonly value="${boardDto.writer}" /><!-- value="${login.name}"; -->
				</div>
				<div class="mb-3">
					<label for="writer">작성일</label>
					<input type="text" class="form-control" name="regdate" id="regdate" readonly value="${boardDto.regdate}" /><!-- value="${login.name}"; -->
				</div>
				<div class="mb-3">
					<label for="content">글내용</label>
					<textarea class="form-control" rows="4" name="content" id="content" readonly >${boardDto.content }</textarea>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</article>
</body>
<script>
function modify() {
	var title = $("#title").val();
	var content = $("#content").val();
	if(title == "") {
		alert("제목을 입력해주세요").
		$("#title").focus();
		return;
	}
	if(content == "") {
		alert("제목을 입력해주세요").
		$("#content").focus();
		return;
	}
	var modify = confirm("글을 수정하시겠습니까?");
	var modifyForm = $("#modifyForm").serialize(); 
	if(modify) {
		$.ajax({
			url : "/board/boardModify",
			type : "post",
			data : modifyForm,
			success : function(data){
				location.href = "/board/boardMain";
				console.log("성공");
			}
		})
	}
}
function del() {
	var del = confirm("글을 삭제 하시겠습니까?");
	var deleteForm = $("#modifyForm").serialize();
	if(del) {
		$.ajax({
			url : "/board/boardDelete",
			type : "post",
			data : deleteForm,
			success : function(data) {
				location.href = "/board/boardMain";
			}
		})
	}
}

</script>
</html>