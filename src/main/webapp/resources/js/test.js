$(document).ready(function () {
	var fileDropDiv = $(".fileDrop");
	var templatePhotoAttach = Handlebars.compile($("#templatePhotoAttach").html());
	var templateFileAttach = Handlebars.compile($("#templateFileAttach").html());
	// 전체 페이지 파일
	$(".content-wrapper").on("dragenter dragover drop", function (event) {
		event.preventDefault();
	});
	// 파일 끌어 놓기 기본 이벤트 방지
	fileDropDiv.on("dragenter dragover", function (event) {
		event.preventDefault();
	});
	// 파일 드랍 이벤트 : 파일 전송 처리, 파일 화면 출력
	fileDropDiv.on("drop", function (event) {
		event.preventDefault(); 
		var files = event.originalEvent.dataTransfer.files; 
		var file = files[0]; 
		var formData = new FormData(); 
		formData.append("file", file); 
		$.ajax({
			url: "/mypage/file/upload",
			data: formData, 
			dataType: "text",
			processData: false,
			contentType: false, 
			type: "POST", 
			success: function (data) {
				// 파일정보 가공
				var fileInfo = getFileInfo(data); 
				// 이미지 파일일 경우
				if (data.substr(12, 2) == "s_") {
					console.log("This is Image"); 
					var html = templatePhotoAttach(fileInfo);
				// 이미지 파일이 아닐 경우
				} else {
					html = templateFileAttach(fileInfo);
				} 
				$(".uploadedList").append(html); 
				} 
			});
		});

		// 글 저장 버튼 클릭 이벤트 : 파일명 DB 저장 처리

		$("#writeForm").submit(function (event) {
			 event.preventDefault();
			 var that =	$(this);
			 var str = "";
			 $(".uploadedList.delBtn").each(function(index) {
				 str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'>"
			 });
			 that.append(str);
			 that.get(0).submit();
		});
		// 파일 삭제 버튼 클릭 이벤트 : 파일삭제, 파일명 DB 삭제 처리
		$(document).on("click", ".delBtn", function (event) {
			event.preventDefault();
			var that = $(this); 
			$.ajax({
				url: "/mypage/file/delete",
				type: "post", 
				data: {fileName:$(this).attr("href")}, 
				dataType: "text", 
				success: function (result) {
					if (result == "DELETED") {
						alert("삭제되었습니다.");
						that.parents("li").remove(); 
						} 
					} 
				});
			}); 
		});

		