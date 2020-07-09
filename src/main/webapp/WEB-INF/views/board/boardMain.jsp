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
<article>
	<div class="container">
		<div class="table-responsive">
			<table class="table table-striped table-sm">
				<%-- <c:if test="${login.grade == 9}">
					<div style="width:650px;" align="right">
						<a href="/boardInsert">글쓰기</a>
					</div>
				</c:if> --%>
					<div style="width: 50px; float: left;">글번호</div>
					<div style="width: 300px; float: left;">제목</div>
					<div style="width: 100px; float: left;">작성자</div>
					<div style="width: 100px; float: left;">작성일</div>
					<tbody>
					<c:forEach items="${boardList }" var="dto">
							<div style="width: 50px; float: left;">${dto.num }</div>	
							<div style="width: 300px; float: left;"><a href="/board/boardDetail">${dto.title }</a></div>
							<div style="width: 100px; float: left;">${dto.writer }</div>
							<div style="width: 100px; float: left;">${dto.regdate }</div> 
						<hr style="width: 600px">
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</article>
</body>
</html>