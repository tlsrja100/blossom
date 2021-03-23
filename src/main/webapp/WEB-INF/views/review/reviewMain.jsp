<%@page import="java.util.List"%>
<%@page import="com.blossom.dto.ReviewDto"%>
<%@page import="com.blossom.dto.ReviewFileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../include/header.jsp" %>
<link rel="stylesheet" href="/resources/css/reviewMain.css">
<meta charset="UTF-8">
<title>미용후기</title>
</head>
<body>
	<br />
	<div class="wrap" >
		<c:if test="${login.grade == 9 }">
			<div class="insertDiv">
				<button type="button" class= "btn btn-default" onclick="location.href='/review/reviewInsert'" style="float:right;">글쓰기</button>
			</div>
		</c:if>
		<ul class="review_ul">
			<c:forEach items="${map.reviewList }" var="dto" >
			<li class="review_li">
				<div class="review_box">
					<input type="hidden" name="rnoVal" value="${dto.rno }" />
					<div class="review_img">
						<input type="hidden" value="${dto.attachList }" />
						<c:forEach items="${dto.attachList }" var="attach" varStatus="i">
							<input type="hidden" value="${attach.rno }" />
							<a href="/review/reviewDetail?rno=${dto.rno }" ><img src="/display?fileName=${attach.uploadPath}/${attach.uuid}_${attach.fileName}" class="img" /></a>
						</c:forEach>
					</div>
					<div class="review_title">
						<a href="/review/reviewDetail?rno=${dto.rno }">${dto.title}</a>
					</div>
					<div class="review_writer">
						<span>${dto.writer }</span>
					</div>
					<div class="review_info">
						<span class="review_readcnt">
							<i class="fa fa-eye" ></i>
							${dto.readcnt}
						</span>
						<span class="review_date">
							<i class="far fa-calendar"></i>
							${dto.regdate }
						</span>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
		<!-- paging 처리 -->
			<div class="text-center">
				<ul class="pagination">
					<!-- 처음 페이지로 이동 : 현재 페이지가 1보다 크면 [처음] 하이퍼링크를 화면에 출력 -->
					<c:if test="${map.pager.curPage > 1}">
						<li><a href="reviewMain?curPage=1">처음</a></li>
					</c:if>
					
					<!-- 이전 페이지로 이동 : 현재 페이지 블럭이 1보다 크면 [이전] 하이퍼링크를 화면에 출력-->
					<c:if test="${map.pager.curBlock > 1}">
						<li><a href="reviewMain?curPage=${map.pager.prevPage}">이전</a></li>
					</c:if>
					
					<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
					<c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
						<!--현재 페이지면 하이퍼링크 제거 -->
						<c:choose>
							<c:when test="${num == map.pager.curPage}">
								<li><span style="color:red">${num}</span></li>
							</c:when>
							<c:otherwise>
								<li><a href="reviewMain?curPage=${num}">${num}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<!-- 다음 페이지 블럭으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음] 하이퍼링크를 화면에 출력 -->
					<c:if test="${map.pager.curBlock <= map.pager.totBlock}">
						<li><a href="reviewMain?curPage=${map.pager.nextPage}">다음</a></li>
					</c:if>
					
					<!-- 끝 페이지로 이동 : 현제 페이지가 전체 페이지보다 작거나 같으면 [끝] 하이퍼링크를 출력 -->
					<c:if test="${map.pager.curPage <= map.pager.totPage}">
						<li><a href="reviewMain?curPage=${map.pager.totPage }">끝</a></li>
					</c:if>
				</ul>
			</div>
	</div>
</body>
</html>