<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Abel&display=swap"rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.a {
	font-size: 100%;
	font-family: 'Abel', sans-serif;
	float: right;
	line-height: 170%;
	margin-right: 15px;
}
/* .headerstyle {
	border-bottom: 1px solid;
}
 */
.buttonstyle {
	-webkit-appearance: none !important;
	color: inherit !important;
	display: inline-block !important;
	position: relative !important;
	white-space: nowrap !important;
	background: transparent !important;
	border-width: initial !important;
	border-style: none !important;
	border-color: initial !important;
	border-image: initial !important;
	text-decoration: none !important;
	margin: 0px !important;
	padding: 0px 8px !important;
	float: right;
	height: 100% !important;
}

.header {
	height: 30px;
}

.header ul li {
	list-style: none;
}
.mainimg {
	text-align:center;
}
.manubar {
	text-align:center;
}
.manu {
	font-size:130%;
	padding : 30px;
	font-family: 'Noto Sans KR', sans-serif;
	text-decoration:none;
	color: black; text-decoration: none;
}
</style>
<body>
<nav class="header">
<c:if test="${empty login}">
	<ul>
		<li>
			<%@include file="../views//blossom/login.jsp" %>
			<!-- data-toggle = 모달기능을 수행함을 의미      data-target = 버튼 클릭시 모달로 띄우고자 하는 id값을 #으로 연결 -->
			<button type="button" class="buttonstyle" id="login" data-toggle="modal" data-target="#myModal">
				<div class="a">LOGIN</div>
			</button>
		</li>
	</ul>
	<ul>
		<li>
			<button type="button" class="buttonstyle" onclick="location.href='/blossom/joinpage'">
				<div class="a">JOIN</div>
			</button>
		</li>
	</ul>
	<ul>
		<li>
			<button type="button" class="buttonstyle" onclick="location.href='/board/boardMain'">
				<div class="a">CUSTOMER CENTER</div>
			</button>
		</li>
	</ul>
</c:if>
<c:if test="${!empty login}">
	<ul>
		<li>
			<button type="button" class="buttonstyle" onclick="logout()">
				<div class="a">LOGOUT</div>
			</button>
		</li>
	</ul>
	<ul>
		<li>
			<button type="button" class="buttonstyle" onclick="location.href='/board/boardMain'">
				<div class="a">CUSTOMER CENTER</div>
			</button>
		</li>
	</ul>
	<c:if test="${login.grade == 9}">
		<ul>
			<li>
				<button type="button" class="buttonstyle" id="admin" onclick="location.href='/admin/adminpage'">
					<div class="a">회원정보관리</div>
				</button>
			</li>
		</ul>
	</c:if>
</c:if>
</nav>
	<div class="mainimg">
		<img src="/resources/img/mainImg.PNG" style="width:500px; height:300px;" onclick="location.href='/blossom/mainpage'"/>
	</div>
	<div class="manubar">
		<a href="" class="manu">블라썸독</a>
		<a href="/board/boardMain" class="manu">공지사항</a>
		<a href="" class="manu">미용사소개</a>
		<a href="/review/reviewMain" class="manu">미용후기</a>
		<a href="/blossom/loadmap" class="manu">오시는길</a>
	</div>
</body>
<script>
/* $(function(){
	$(".login").click(function(){
		$(".modal").modal();
	})
})
 */
function logout(){
	location.href = "/blossom/logout";
}

</script>
</html>