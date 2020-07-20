<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e8b7a6ffda4ad48536c772572e70842c"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.map-div{
	display : flex;
	justify-content : center;
}
</style>
<body>
	<br />
	<div class="map-div">	
	<div id="map" style="width:500px; height:400px;"></div>
	</div>
	<br />
	<div style="text-align:center;">
		<p>02-808-0414</p>
		<p>주소 : 서울 금천구 벚꽃로 30 금천롯데캐슬골드파크 2차 142호 블라썸독지번독산동 1150</p>
		<p>영업시간 : 매일 11:00~20:00 저녁 6시 이후 야간미용가능( 문의주세요) </p>
	</div>
</body>
	<script>
		var container = document.getElementById('map');
		var options = {	//지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(37.458419, 126.894762),	// 지도의 중심좌표
				level : 3	// 지도의 레벨(확대, 축소 정도)
		};
		
		var map = new kakao.maps.Map(container, options);	//지도 생성 및 객체 리턴
	
		// 마커가 표시될 위치
		var markerPosition = new kakao.maps.LatLng(37.458419, 126.894762);	
	
		// 마커 생성
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정
		marker.setMap(map);
		
	</script>
</html>