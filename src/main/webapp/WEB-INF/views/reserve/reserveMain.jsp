<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../include/header.jsp" %>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>예약하기</title>
</head>
<style>
#teacher {
	display: block;
	text-align: -webkit-center;
}
.teacherli {

	display: list-item;
	text-align: -webkit-match-parent;
	padding: 18px;
	width: 800px;
	border-bottom: 1px solid #DCDCDC;
}

#teacherImg {
	width: 300px;
	height: 200px;
}

#reserveBtn {
	border-color: green;
	width: 80px;
	background-color: white;
	color: green;
}
/* modal */
.reserveUl {
	list-style: none;
}

.reserveUl li {
	float: left;
	width: 25%;
}

.anchor {
	display: block;
	padding: 9px 0;
	margin: 0 2px 5px;
	background-color: #edfbdc;
	border: 1px solid #c8e1af;
	text-align: center;
	color: #424242;
	font-size: 15px;
}

.anchor:hover {
	text-decoration: none;
	border: 1px solid #87d923;
	color: #87d923;
}

#datepicker {
	padding: 4px 2px 5px 30px;
	width: 150px;
	border: 1px solid #CACACA;
	background: url("/resources/img/btn_date.png") no-repeat 2px 2px;
	background-size: 23px;
}

#dateBtn {
	width: 50px;
	height: 25px;
	display: block;
	border: 1px solid rgba(3, 199, 90, 0.6);
	border-radius: 4px;
	background: #fff;
	font-size: 1.5rem;
	text-align: center;
}

.anchorVal {
	display: block;
	padding: 9px 0;
	margin: 0 2px 5px;
	text-align: center;
	font-size: 15px;
	border: 1px solid #dedfe5;
	background-color: #f5f7f7;
	color: #ccc;
	text-decoration: none;
	pointer-events : none;
	cursor : default;
}
</style>
<body>
<br /><br /> 
<br />
	<div id="teacher" >
		<ul style="list-style: none; display:block;">
			<c:forEach items="${list }" var="dto" varStatus="vs">
				<li class="teacherli" >
				<div style="display:block; float:right;">
					<img src="/designerDisplay?fileName=${dto.uploadPath}/${dto.uuid}_${dto.fileName}" id="teacherImg" />
				</div>
				<div style="display:block; height:200px;">
					<div style="display:block; float:left;">
						<div style="text-align:left;">
							<input type="hidden" id="dnoVal" name="dno" value="${dto.dno }"/>
							<h2 >${dto.designer_name }</h2>
						</div>
						<div style="white-space:pre; text-align:left; margin-top:5px;">${dto.designer_memo }</div>
						<div style="float:left; margin-top:50px;">
							<%-- <%@include file="reserve.jsp"%> --%>
							<button type="button" class="btn btn-primary" id="reserveBtn" data-dno="${dto.dno }" data-name="${dto.designer_name }" data-toggle="modal" data-target="#reserveModal">예약</button>
						</div>
					</div>
				</div>
				</li>
			</c:forEach>
		</ul>
		<br />
	</div>
	<!-- modal -->
	<div class="modal fade" id="reserveModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" style="width :auto; height:auto;">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 346px; height: 450px;">
				<!-- Modal Header -->
				<div class="modal-header" >
					<button class="close" type="button" data-dismiss="modal" aria-label="close">x</button>
						<h4 class="modal-title" id="designer_name" style="text-align:center;" ></h4>
						<input type="hidden" id="hiddenDno" name="dno_seq" />
						<input type="hidden" id="hiddenCno" name="cno_seq" value="${login.cno }"/>

				</div>
				<!-- Modal Body -->
				<form action="/reserve" method="post" id="modalForm">
					<div class="modal-body">
						<div style="height: 350px; text-align:center;" >
							<label for="checkin" >예약하기</label>
							<div style="height: 35px;">
								<div style="float: left; margin-left: 80px;">
									<input type="text"  id="datepicker" name="datepicker" />
								</div>
								<div style="float: right; margin-right: 23px; margin-top: 3px;">
									<button type="button" id="dateBtn" name="dateBtn">검색</button>
									<br />
								</div>
							</div>
							<br />
							<div class="timediv" style="border-top: 1px solid #e5e5e5; padding: 13px 0 17px;">
								<div class="deletediv">
									<div style="height: 80px;">
										<span style="font-size: 17px; padding-bottom: 7px; padding-left: 7.5px; margin-right: 230px; float: left;">오전</span><br />
										<ul class="reserveUl">
											<li><a href="#" class="anchor" id="teen" >10:00</a></li>
											<li><a href="#" class="anchor" id="eleven">11:00</a></li>
											<li><a href="#" class="anchor" id="tweleve">12:00</a></li>
										</ul>
									</div>
									<br />
									<div style="height: 120px;">
										<span style="font-size: 17px; margin-top: 6.5px; padding-bottom: 7px; padding-left: 7.5px; margin-right: 230px; float: left;">오후</span><br />
										<ul class="reserveUl">
											<li><a href="#" class="anchor" id="one">1:00</a></li>
											<li><a href="#" class="anchor" id="two">2:00</a></li>
											<li><a href="#" class="anchor" id="three">3:00</a></li>
											<li><a href="#" class="anchor" id="four">4:00</a></li>
											<li><a href="#" class="anchor" id="five">5:00</a></li>
											<li><a href="#" class="anchor" id="six">6:00</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!-- Modal Footer -->
				<div class="modal-footer" style="background: gainsboro; text-align: center;">
					<button type="button" class="btn btn primary" style="background: none; font-size: 20px;" onclick="reserve()">예약하기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
$(document).on("click", "#reserveBtn",function(){
	var dno = $(this).data("dno");
	$(".modal-header #hiddenDno").val(dno);
	var designer_name = $(this).data("name");
	$(".modal-header #designer_name").text(designer_name);
});
$(".close").click(function(){
	location.reload();
})

var anchor = "";



$(function() {
	$("#datepicker").datepicker({
		dateFormat : 'yy-mm-dd',
		maxDate : "+1m",
		minDate : "0",
		//buttonImage: "/resources/img/btn_date.png",
		daysOfWeekDisabled : [ 0 ],
		yearRange : 'c-80:c+10',
		daysOfWeekHighlighted : [ 0 ],
		dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ]
	})
})
$(function() {
	$(".anchor").click(function() {
		$(".anchor").css("backgroundColor", "#edfbdc");
		$(".anchor").css("color", "#424242");
		$(event.target).css("backgroundColor", "#00c73d");
		$(event.target).css("color", "#fff");
		$(event.target).css("text-decoration", "none");
		anchor = $(event.target).text();
		console.log(anchor);
	})
	return anchor;
})

$("#dateBtn").click(function() {
	var day = $("#datepicker").serialize();
	var dno = $("#hiddenDno").val();
	console.log(day);
	console.log($("#datepicker").val())
	console.log(dno);
	$.ajax({
			url : "/reserve/timeCheck",
			type : "post",
			data : {
				day : $("#datepicker").val(),
				dno : $("#hiddenDno").val()
			},
			dataType : "json",
			success : function(result) {
				var time = $(".anchor").text();
				console.log(anchor);
				var list = result.timeList;
				console.log("list", list);
				//$(".anchorVal").attr('class','anchor');
				var atag = "";
				$(".deletediv").remove();
				atag += "<div class='deletediv'>"
				atag += "<div style='height: 80px;'>"
				atag += "<span style='font-size: 17px; padding-bottom: 7px; padding-left: 7.5px; margin-right: 230px; float: left;'>오전</span><br />"
				atag += "<ul class='reserveUl'>"
				atag += "<li><a href='#' class='anchor' id='teen'>10:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='eleven'>11:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='tweleve'>12:00</a></li>"

				atag += "</ul>"
				atag += "</div><br />"
				atag += "<div style='height: 120px;'>"
				atag += "<span style='font-size: 17px; margin-top: 6.5px; padding-bottom: 7px; padding-left: 7.5px; margin-right: 230px; float: left;'>오후</span><br />"
				atag += "<ul class='reserveUl'>"

				atag += "<li><a href='#' class='anchor' id='one'>1:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='two'>2:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='three'>3:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='four'>4:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='five'>5:00</a></li>"
				atag += "<li><a href='#' class='anchor' id='six'>6:00</a></li>"

				atag += "</ul>"
				atag += "</div>"
				atag += "</div>"
				$(".timediv").append(atag);
				for (var i = 0; i < list.length; i++) {
					if (list[i].time == $("#teen").text()) {
						$("#teen").attr("class", "anchorVal");
					}
					if (list[i].time == $("#eleven").text()) {
						$("#eleven").attr("class", "anchorVal");
					}
					if (list[i].time == $("#tweleve").text()) {
						$("#tweleve").attr("class", "anchorVal");
					}
					if (list[i].time == $("#one").text()) {
						$("#one").attr("class", "anchorVal");
					}
					if (list[i].time == $("#two").text()) {
						$("#two").attr("class", "anchorVal");
					}
					if (list[i].time == $("#three").text()) {
						$("#three").attr("class", "anchorVal");
					}
					if (list[i].time == $("#four").text()) {
						$("#four").attr("class", "anchorVal");
					}
					if (list[i].time == $("#five").text()) {
						$("#five").attr("class", "anchorVal");
					}
					if (list[i].time == $("#six").text()) {
						$("#six").attr("class", "anchorVal");
					}
				}
				$(function() {
					$(".anchor").click(function() {
						$(".anchor").css("backgroundColor","#edfbdc");
						$(".anchor").css("color", "#424242");
						$(event.target).css("backgroundColor","#00c73d");
						$(event.target).css("color", "#fff");
						$(event.target).css("text-decoration","none");
						anchor = $(event.target).text();
						console.log(anchor);
					})
					return anchor;
				})
			}
		})
})



function reserve() {
	var day = $("#datepicker").val();
	var time = anchor;
	var dno_seq = $("#hiddenDno").val();
	var cno_seq = $("#hiddenCno").val();

	if(cno_seq == "") {
		alert("로그인 후 이용해주세요");
		return false;
	}
	var reserve = confirm("예약 하시겠습니까?");
	if(reserve) {
		$.ajax({
			url : "/reserve/reserve",
			type : "post",
			data : {
				day : $("#datepicker").val(),
				time : anchor,
				dno_seq : $("#hiddenDno").val(),
				cno_seq : $("#hiddenCno").val()
			},
			dataType: "json",
			success : function(data) {
				setTimeout(function(){
					alert("예약되셨습니다.");
					location.href = "/reserve/reserveMain";
				},1000);
			}
		})
	}
}
</script>
</html>