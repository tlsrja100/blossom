<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.header {
	background: white;
	height: 40px;
}
.header ul li {
	list-style: none;
}
</style>
<body>
	<nav class="header">
		<img src="/resources/img/name.PNG" style="height:auto; width:300px;"/>
		<button style="border: 0; float: right; background: none; color : black; font-size:larger; " onclick="location.href='/blossom/mainpage'">Main</button>
	</nav>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<nav class="side" style="float:left; width:300px;">
		<ul>
			<li>
				<button type="button" onclick="location.href = '/admin/adminpage'">
					<div>회원목록</div>
				</button>
			</li><br />
			<li>
				<button type="button" onclick="location.href= '/admin/designerPage'">
					<div>디자이너</div>
				</button>
			</li>
		</ul>
		<!-- <a href="/admin/adminpage">회원목록</a> -->
	</nav>
</body>
</html>