<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<%
	String modify = (String)request.getAttribute("modify");
	if(modify == null) {
		modify = "true";
	} else {
		%>
		<script>
			alert("비밀번호를 성공적으로 변경하였습니다. 다시 로그인 해주세요");
		</script>
	<%
	}
%>
<%
	String msg = (String)request.getAttribute("msg");
	if(msg == null) {
		msg = "true";
	} else {
		%>
		<script>
			alert("아이디 또는 비밀번호를 잘못 입력하셨습니다.");
		</script>
		<%
	}
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



</body>
</html>
