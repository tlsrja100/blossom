<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp"%>
<link rel="stylesheet" href="/resources/css/reviewInsert.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="wrap">
		<form action="/review/reviewModify" method="post" id="reviewForm" role="form" enctype="multipart/form-data"  > 
			<c:choose>
				<c:when test="${login.grade == 9 }">
					<input type="hidden" name="rno" id="rno" value="${dto.rno }" />
					<div class="mb-3">	
						<label for="title">제목</label>
						<input type="text" class="form-control" name="title" id="title"   value="${dto.title }"/>
					</div>
					<div class="mb-3">
						<label for="writer">작성자</label>
						<input type="text" class="form-control" name="writer" id="writer"  value="${dto.writer }" /><!-- value="${login.name}"; -->
					</div>
					<div class="mb-3">
						<label for="content">글내용</label> 
						<textarea class="form-control" rows="4" name="content" id="content"   >${dto.content }</textarea>
					</div>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="rno" id="rno" value="${dto.rno }" />
					<div class="mb-3">	
						<label for="title">제목</label>
						<input type="text" class="form-control" name="title" id="title" readonly  value="${dto.title }"/>
					</div>
					<div class="mb-3">
						<label for="writer">작성자</label>
						<input type="text" class="form-control" name="writer" id="writer" readonly value="${dto.writer }" /><!-- value="${login.name}"; -->
					</div>
					<div class="mb-3">
						<label for="content">글내용</label> 
						<textarea class="form-control" rows="4" name="content" id="content" readonly  >${dto.content }</textarea>
					</div>
				</c:otherwise>
			</c:choose>

			<!-- 이미지 업로드 구간 시작 -->
			<div class="panel panel-default">
				<div class="panel-heading">미용사진 </div>
				<div class="panel-body">
					<div class="fileDrop" >
						<ul>
							<!-- 이미지 썸네일 보여지는 곳 -->
						</ul>
					</div>
					
					<!-- 관리자만 볼수있는곳  -->
					<c:if test="${login.grade == 9 }">
						<div class="file_div">
							<div class="file_Btn" >
								<input type="file" name="uploadFile" /><br />
								 <span style="text-size:12px; color:red">* 제일 처음 등록한 사진이 썸네일이 됩니다.</span>
							</div>
						
							<div class="file_Upload">
								<button type="button" class="btn btn-primary btn-clock" id="uploadImg">사진등록</button>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<c:if test="${login.grade == 9 }">
				<!-- 이미지 업로드 구간 끝 -->
				<div class="submitBtn">
					<button type="submit" class="btn btn-success" >등록</button>
				</div>
			</c:if>
		</form>
	</div>
</body>
<script>
$(document).ready(function(){
	var rno = "<c:out value='${dto.rno}'/>"
	$.getJSON("/review/getAttachList", {rno:rno}, function(arr){
		console.log(arr);
		var str = "";
		$(arr).each(function(i,attach){
			if(attach.fileType) {
				var filePath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
				str+="<li data-path = '"+ attach.uploadPath + "'";
    			str+="data-uuid = '" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type = '" + attach.fileType + "'";
    			str+="><div>";
    			str+="<img src='/display?fileName=" + filePath + "' data-file='"+ filePath +"' data-type='image'>";
			}
		})
		$(".fileDrop ul").append(str);
	})
	
	var formObj = $("form[role='form']");
	$("button[type='submit']").click(function(e){
		e.preventDefault();
		var fileDrop = $(".fileDrop ul");
		var str = "";
		$(".fileDrop ul li").each(function(i,obj){
			var job = $(obj);
			console.dir(job);
			str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+job.data("uuid")+"'>";
	        str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+job.data("path")+"'>";
	        str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+job.data("filename")+"'>";
	        str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+job.data("type")+"'>";
		});
		formObj.append(str).submit();

	});
	
	
	// 첨부파일의 크기와 확장자 제한
    function checkExtension(fileName, fileSize){
       var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 정규식 패턴 // 확장자 막음
       var maxSize = 5242880; // 5MB
       
       if(fileSize > maxSize){
          alert("파일 사이즈 초과");
          return false;
       }
       if(regex.test(fileName)){
          alert("이미지만 업로드할 수 있습니다.");
          return false;
       }
       return true;
    } // checkExtension 종료
    
	$("#uploadImg").click(function(){
		console.log("등록하기 버튼 클릭");
		var formData = new FormData();
		var inputFile=$("input[name='uploadFile']");
		var files=inputFile[0].files;
		
		for(var i=0; i < files.length;i++){
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			} 
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			url : "/uploadAjax",
			processData : false,   // formData를 쓸때 무조건 필요함(데이터를 어떤방식으로 변환할 것인지 결정)
            contentType : false,   // formData를 쓸때 무조건 필요함(formData가 기본적으로  application/x-www-form-urlencoded인 상황이라 false로 지정)
            data : formData,
            type :"post",
            dataType : "json",      // 되돌아오는 데이터 타입 (전송이 잘 되면 success라는 문자열을 전송받을 예쩡)
            success:function(result) {
               console.log(result);   // 브라우저에 찍힌 파일내용
               showUploadedFile(result);
            }
		});
	});	
    
    // 서버에서 result를 받은 후 result 보여주기
    function showUploadedFile(uploadResultArr) {
    	if(!uploadResultArr || uploadResultArr.length == 0){return;}
		var uploadResult = $(".fileDrop ul");
    	// 결과 보여줄 영역
    	//console.log("uploadResult : ",uploadResult);
    	var str="";
    	$(uploadResultArr).each(function(i,obj){
    		if(obj.fileType) {
    			var filePath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
    			str+="<li data-path = '"+ obj.uploadPath + "'";
    			str+="data-uuid = '" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type = '" + obj.fileType + "'";
    			str+="><div>";
    			str+="<img src='/display?fileName=" + filePath + "' data-file='"+ filePath +"' data-type='image'>";
    		}
    	});
    	uploadResult.append(str);
    }
 	// X를 클릭하면 첨부된 파일 삭제하기
    $(".fileDrop").on("click","img",function(){
    // 첨부목록 삭제
	if(confirm("사진을 삭제 하시겠습니까?")) {
	    // 첨부목록 삭제
		var targetLi=$(this).closest("li");
		targetLi.remove();	   
		};
    });
})


</script>
</html>