<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<link rel="stylesheet" href="/resources/css/login.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- modal -->
<div class="modal fade" id="myModal" tabindex="1"role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" >
	<!-- modal content -->
		<div class="modal-content" >
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">x</button>
				<h4 class="modal-title" id="myModalLabel">로그인</h4>
			</div>
			<div class="modal-body">
				<div style="text-align:center; ">
					<img src="/resources/img/login.png" alt="" />
				</div>
				<form id="loginform"> <!-- action="/login" method="post"   -->
					<div class="input-group">
						<span class="input-group-addon" >
							<svg viewBox="0 0 24 24" role="presentation" aria-hidden="true"	focusable="false" style="height: 1em;width: 1em;  display: block; fill: currentcolor;">
								<path d="m22.5 4h-21c-.83 0-1.5.67-1.5 1.51v12.99c0 .83.67 1.5 1.5 1.5h20.99a1.5 1.5 0 0 0 1.51-1.51v-12.98c0-.84-.67-1.51-1.5-1.51zm.5 14.2-6.14-7.91 6.14-4.66v12.58zm-.83-13.2-9.69
								7.36c-.26.2-.72.2-.98 0l-9.67-7.36h20.35zm-21.17.63 6.14 4.67-6.14 7.88zm.63 13.37 6.3-8.1 2.97 2.26c.62.47 1.57.47 2.19 0l2.97-2.26 6.29 8.1z" fill-rule="evenodd">
								</path>
							</svg>
						</span>
						<input type="text" class="form-control" style="height:34.4px;" placeholder="E-mail" id="email-login" name="email"></input>
					</div>
					<div class="input-group">
						<span class="input-group-addon" >
							<svg viewBox="0 0 24 24" role="presentation" aria-hidden="true" focusable="false" style="height: 1em; width: 1em; display: block; fill: currentcolor;">
								<path d="m19.5 9h-.5v-2a7 7 0 1 0 -14 0v2h-.5c-.78 0-1.5.72-1.5 1.5v12c0 .78.72 1.5 1.5 1.5h15c .78 0 1.5-.72 1.5-1.5v-12c0-.78-.72-1.5-1.5-1.5zm.5 13.5c0 .22-.28.5-.5.5h-15c-.22 0-.5-.28-.5-.5v-12c0-.22.28-.5.5-.5h1a
								.5.5 0 0 0 .5-.5v-2.5a6 6 0 1 1 12 0v2.5a.5.5 0 0 0 .5.5h1c .22 0 .5.28.5.5zm-8-10.5a3 3 0 0 0 -3 3c0 .83.36 1.59.94 2.15l-.9 2.16a.5.5 0 0 0 .46.69h5a .5.5 0 0 0 .46-.69l-.87-2.19c.56-.55.91-1.31.91-2.13a3 3 0 0 0 
								-3-3zm1.04 5.19.72 1.81h-3.51l.74-1.79a.5.5 0 0 0 -.17-.6 2 2 0 1 1 3.18-1.61c0 .64-.31 1.24-.8 1.6a.5.5 0 0 0 -.17.59zm-1.04-14.19a4 4 0 0 0 -4 4v2.5a.5.5 0 0 0 .5.5h7a .5.5 0 0 0 .5-.5v-2.5a4 4 0 0 0 -4-4zm3 6h-6v-2a3
								3 0 1 1 6 0z" fill-rule="evenodd">
								</path>
							</svg>
						</span>
						<input type="password" class="form-control" style="height:34.4px;" placeholder="Password" id="password" name="password"/>
					</div>
					<br />
					<div class="form-group bu" style="padding-top:10px;" ><!-- "col-md-3 col-sm-3 col-xs-6"  --> 
							<button type="button" class="btn btn-sm animated-button thar-two" style="width:100px; height:30px; margin-left:45px;text-align:center;" onclick="loginbtn()">Login</button> 
					</div>
				</form>
				<c:if test="${mm == false }">
				<script>
					alert("a");
				</script>
						<!-- <p style="color:#f00;">로그인에 실패했습니다.</p> -->
				</c:if>
			</div>
		</div>
	</div>
</div>	
</body>
<script>
var result = "${message}";
function loginbtn() {
	var email = $("#email-login").val();
	var password = $("#password").val();
	if(email == ""){
		alert("이메일을 입력하세요");
		$("#email").focus();
		return;
	}
	if(password == ""){
		alert("비밀번호를 입력하세요");
		$("#password").focus();
		return;
	}
 	var login = $("#loginform").serialize();
	if(login) {
		$.ajax({
			url : "/blossom/login",
			type : "post",
			data : login,
			success : function(data) {
				console.log(login);
				location.href = "/blossom/mainpage";
			},
			error : function(request,status,error){
				alert("이메일 또는 패스워드를 확인해주세요.");
				location.href = "/blossom/mainpage";
				
			}
		})
	} 
}

</script>
</html>