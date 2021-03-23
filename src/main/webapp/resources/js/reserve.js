/* reserve */
$(document).on("click", "#reserveBtn",function(){
	var dno = $(this).data("dno");
	$(".modal-header #hiddenVal").val(dno);
	var designer_name = $(this).data("name");
	$(".modal-header #designer_name").text(designer_name);
});
$(".close").click(function(){
	location.reload();
})

var anchorVal = function() {
	var anchor = $(event.target).text();
	return anchor;
	console.log(anchor);
}


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
		console.log(anchorVal());
	})
})

$("#dateBtn").click(function() {
	var day = $("#datepicker").serialize();
	var dno = $("#hiddenVal").val();
	console.log(day);
	console.log(dno);
	$.ajax({
			url : "/reserve/timeCheck",
			type : "post",
			data : {
				day : $("#datepicker").val(),
				dno : $("#hiddenVal").val(),
				time : anchorVal()
			},
			dataType : "json",
			success : function(result) {
				var time = $(".anchor").text();
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
						console.log(anchorVal());
					})
				})
			}
		})
})