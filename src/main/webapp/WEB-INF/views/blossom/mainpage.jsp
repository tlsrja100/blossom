<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp" %>
<link rel="stylesheet" href="/resources/css/mainpage.css">
<!-- <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet"> -->
<meta charset="UTF-8">
<title>블라썸독</title>
</head>
<body>
<div class="wrap">
	<div class="contents">
		<div class="banner">
			<ul>
				<li><img src="/resources/img/banner7.jpg"></li>
				<li><img src="/resources/img/banner6.jpg"></li>
				<li><img src="/resources/img/banner9.jpg"></li>
			</ul>
		</div>
	</div>
</div>
</body>
<script>
$(document).ready(
		function() {
			//사용할 배너
			var $banner = $(".banner").find("ul");

			var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
			var $bannerHeight = $banner.children().outerHeight(); // 높이
			var $bannerLength = $banner.children().length;//배너 이미지의 갯수
			var rollingId;
			console.log($bannerWidth);
			//정해진 초마다 함수 실행
			rollingId = setInterval(function() {
				rollingStart();
			}, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

			//마우스 오버시 롤링을 멈춘다.
			$banner.mouseover(function() {
				//중지
				clearInterval(rollingId);
				$(this).css("cursor", "pointer");
			});
			//마우스 아웃되면 다시 시작
			$banner.mouseout(function() {
				rollingId = setInterval(function() {
					rollingStart();
				}, 3000);
				$(this).css("cursor", "default");
			});
			function rollingStart() {
				$banner.css("width", $bannerWidth * $bannerLength + "px");
				$banner.css("height", $bannerHeight + "px");
				//alert(bannerHeight);
				//배너의 좌측 위치를 옮겨 준다.
				$banner.animate({
					left : -$bannerWidth + "px"
				}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
					//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
					$(this).append(
							"<li>" + $(this).find("li:first").html()
									+ "</li>");
					//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
					$(this).find("li:first").remove();
					//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
					$(this).css("left", 0);
					//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
				});
			}
		});
</script>
</html>
