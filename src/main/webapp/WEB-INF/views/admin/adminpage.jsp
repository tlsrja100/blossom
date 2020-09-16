<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../include/adminheader.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="cantainer" style="float:left; width:1000px;">
		<table class="table table-hover">
			<h2>회원목록</h2>
			<br />
			<tr>
				<th style="width:300px;">이메일</th>
				<th style="width:150px;">이름</th>
				<th style="width:200px;">전화번호</th>
				<th style="width:400px; text-align:center;">주소</th>
			</tr>
			<c:forEach items="${list}" var="user">
				<tr>
					<td>${user.email}</td>
					<td>${user.name}</td>
					<td>${user.phone }</td>
					<td>${user.addr2 }</td>
				</tr>
			</c:forEach>
		</table>

		<span style="float:left;">총 ${count }명의 회원이 있습니다.</span>
	
		<form action="/admin/adminpage" method="post">
			<span style="float:right;">
				<select name="searchOption" style="padding-bottm:1px;height: 25px;">
					<option value="all" <c:out value="${searchOption == 'all'?'selected':''}" />>이메일  + 이름</option>
					<option value="email" <c:out value="${searchOption == 'email'?'selected':''}" />>이메일</option>
					<option value="name" <c:out value="${searchOption == 'name'?'selected':''}" />>이름</option>
				</select>
				<input name="keyword" value="${keyword}"/>
				<input type="submit" class="btn btn-default" style="padding-top:3px;padding-bottom: 3px;" value="검색"/>
			</span>
		</form>
		
		<!-- paging 처리 -->
		<div class="text-center">
			<ul class="pagination">
				<!-- 처음 페이지로 이동 : 현재 페이지가 1보다 크면 [처음] 하이퍼링크를 화면에 출력 -->
				<c:if test="${pager.curPage > 1}">
					<li><a href="adminpage?curPage=1">처음</a></li>
				</c:if>
				
				<!-- 이전 페이지로 이동 : 현재 페이지 블럭이 1보다 크면 [이전] 하이퍼링크를 화면에 출력-->
				<c:if test="${pager.curBlock > 1}">
					<li><a href="adminpage?curPage=${pager.prevPage}">이전</a></li>
				</c:if>
				
				<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
				<c:forEach var="num" begin="${pager.blockBegin}" end="${pager.blockEnd}">
					<!--현재 페이지면 하이퍼링크 제거 -->
					<c:choose>
						<c:when test="${num == pager.curPage}">
							<li><span style="color:red">${num}</span></li>
						</c:when>
						<c:otherwise>
							<li><a href="adminpage?curPage=${num}">${num}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 다음 페이지 블럭으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음] 하이퍼링크를 화면에 출력 -->
				<c:if test="${pager.curBlock <= pager.totBlock}">
					<li><a href="adminpage?curPage=${pager.nextPage}">다음</a></li>
				</c:if>
				
				<!-- 끝 페이지로 이동 : 현제 페이지가 전체 페이지보다 작거나 같으면 [끝] 하이퍼링크를 출력 -->
				<c:if test="${pager.curPage <= pager.totPage}">
					<li><a href="adminpage?curPage=${pager.totPage }">끝</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>