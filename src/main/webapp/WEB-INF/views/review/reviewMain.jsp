<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../include/header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
			<button type="button" class= "btn btn-default" onclick="location.href='/review/reviewInsert'" style="float:right;">글쓰기</button>
	<%-- <div class="container" style="width: 1000px;">
	<table class="table table-hover">
		<c:if test="${login.grade == 9}">
		</c:if>
		
	</table>
	</div> --%>
</body>
</html>