<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../include/header.jsp"%>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<br />
	<article>
		<div class="container" style="width: 1000px;">
			<table class="table table-hover">
				<!-- 관리자로 로그인 했을 경우 글쓰기 button 보이기 -->
				<c:if test="${login.grade == 9}">
					<div style="float:right; margin-bottom:5px;">
						<button type="button"  class="btn btn-default" id="writeForm" onclick="location.href='/board/boardInsert'">글쓰기</button>
					</div>
				</c:if> 
				<tr>
					<th>NO</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<c:forEach items="${map.list }" var="dto">
					<tr>
						<td>${dto.num }</td>
						<td><a href="/board/boardDetail?num=${dto.num}">${dto.title }</a></td>
						<td>${dto.writer }</td>
						<td>${dto.regdate }</td>
					</tr>
				</c:forEach>
			</table>
			<input type="hidden" name="boardnum" value="${dto.num }" />
			<span style="text-align:left;">${map.count }개의 게시물이 있습니다.</span>
			
			<!-- 검색 -->
			<form action="boardMain" method="post">
				<span style="float:right;">
					<select name="searchOption" style="padding-bottm:1px;height: 25px;">
						<option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}" />>제목 + 내용</option>
						<option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}" />>제목</option>
						<option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}" />>내용</option>
					</select>
					<input name="keyword" value="${map.keyword }"/>
					<input type="submit" class="btn btn-default" style="padding-top:3px;padding-bottom: 3px;" value="조회" />
				</span>
			</form>
			<br />
			<br />
			
			<!-- paging 처리 -->
			<div class="text-center">
				<ul class="pagination">
					<!-- 처음 페이지로 이동 : 현재 페이지가 1보다 크면 [처음] 하이퍼링크를 화면에 출력 -->
					<c:if test="${map.pager.curPage > 1}">
						<li><a href="boardMain?curPage=1">처음</a></li>
					</c:if>
					
					<!-- 이전 페이지로 이동 : 현재 페이지 블럭이 1보다 크면 [이전] 하이퍼링크를 화면에 출력-->
					<c:if test="${map.pager.curBlock > 1}">
						<li><a href="boardMain?curPage=${map.pager.prevPage}">이전</a></li>
					</c:if>
					
					<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
					<c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
						<!--현재 페이지면 하이퍼링크 제거 -->
						<c:choose>
							<c:when test="${num == map.pager.curPage}">
								<li><span style="color:red">${num}</span></li>
							</c:when>
							<c:otherwise>
								<li><a href="boardMain?curPage=${num}">${num}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<!-- 다음 페이지 블럭으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음] 하이퍼링크를 화면에 출력 -->
					<c:if test="${map.pager.curBlock <= map.pager.totBlock}">
						<li><a href="boardMain?curPage=${map.pager.nextPage}">다음</a></li>
					</c:if>
					
					<!-- 끝 페이지로 이동 : 현제 페이지가 전체 페이지보다 작거나 같으면 [끝] 하이퍼링크를 출력 -->
					<c:if test="${map.pager.curPage <= map.pager.totPage}">
						<li><a href="boardMain?curPage=${map.pager.totPage }">끝</a></li>
					</c:if>
				</ul>
			</div>
			<br />
		</div>
	</article>
</body>

</html>