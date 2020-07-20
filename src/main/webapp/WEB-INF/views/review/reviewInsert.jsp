<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container{
 padding-top: 70px;
 padding-bottom: 30px;
}
.mb-3 {
	padding-top : 20px;
}
.select_img {
	margin : 20px;
}
</style>
<body>
<article>
	<div class="container">
		<form id="reviewForm" role="form"> <!-- action="/review/reviewInsert" method="post" -->
			<div class="mb-3">	
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요."/>
			</div>
			<div class="mb-3">
				<label for="writer">작성자</label>
				<input type="text" class="form-control" name="writer" id="writer" readonly value="${login.name}" /><!-- value="${login.name}"; -->
			</div>
			<div class="mb-3">
				<label for="content">글내용</label>
				<textarea class="form-control" rows="4" name="content" id="content" placeholder="내용을 입력해주세요." ></textarea>
			</div>
			<!-- 이미지 업로드 구간 시작 -->
			<div class="box">
				<!-- 파일업로드 썸네일 부분 -->
				<div class="uploadResult">
	
				</div>
				
				<div >
					<span class="control-fileupload">
						<input type="file" name="uploadFile" multiple="multiple" />
					</span>
					<div class="col-sm-2">
	                	<button type="button" id="uploadIMG" >
	                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-card-image" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd" d="M14.5 3h-13a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h13a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
  							<path d="M10.648 7.646a.5.5 0 0 1 .577-.093L15.002 9.5V13h-14v-1l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71z"/>
  							<path fill-rule="evenodd" d="M4.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
						</svg>
						</button>
	                </div>
				</div>
			</div>
			<hr />				
			<button type="submit" class="btn btn-primary" onclick="reviewbtn()">등록</button>
		</form>
	</div>
</article>
</body>
<script>
/* function reviewbtn() {
	var title = $("#title").val();
	var content = $("#content").val();
	if(title == ""){
		alert("제목을 입력해주세요");
		$("#title").focus();
		return;
	}
	if(content == ""){
		alert("내용을 입력해주세요");
		$("#content").focus();
		return;
	}
	var review = confirm("글을 등록 하시겠습니까?");
	var reviewForm = $("#reviewForm").serialize();
	if(insert) {
		$.ajax({
			url : "/review/reviewInsert",
			type : "post",
			data : insertForm,
			success : function(data){
				location.href = "/review/reviewMain";
			}
		})
	}  */
	
	/* 파일 업로드 부분 시작 */
$(function(){
	var formObj=$("form[role='form']");
	
	$("button[type=submit]").click(function(e){
		e.prevenetDefault();
	
		var str ="";
		$(".uploadResult span").each(function(i,obj) {
			var job=$(obj);
			
			 str+="<input type='hidden' name='uuid["+i+"].uuid' value='"+job.data("uuid")+"'>";
			 str+="<input type='hidden' name='uploadPath["+i+"].uploadPath' value='"+job.data("path")+"'>";
	         str+="<input type='hidden' name='fileName["+i+"].fileName' value='"+job.data("filename")+"'>";
	         str+="<input type='hidden' name='fileType["+i+"].fileType' value='"+job.data("type")+"'>";
		});
		console.log(str);
		formObj.append(str);
		formObj.submit();
	});
	// uploadBtn() 클릭하면 uploadFile에 있는 정보 가져오기
	$("#uploadIMG").click(function(){
		console.log("등록하기 버튼 클릭");
		
		// multipart/form-data 형태의 폼을 한꺼번에 처리하기
		var formData = new FormData();
		// file 안에 들어있는 여러개의 첨부된 파일 가져오기
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i=0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
			} else if (files.length > 4) {
				alert("이미지는 4개까지 등록 가능합니다.");
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		
		// formData를 ajax 사용해서 서버로 전송
		$.ajax({
			url : "/reviewAjax",
			data : formData,
			processData : false,	//formData 사용할때 무조건 필요 (데이터를 어떤방식으로 변환할 것인지 결정)
			contentType : false,	//formData 사용할때 무조건 필요 (formData가 기본적으로 application/x-www-form-urlencoded인 상황이라 false로 지정)
			type : "post",
			dataType : "json",
			success : function(result) {
				console.log(result);
				showUploadFile(result);
			}
		});
	});	//uploadBtn 종료
	
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
    
    // 서버에서 result를 받은 후 result 보여주기
    function showUploadFile(uploadResultArr) {
    	//결과를 보여줄 영역 가져오기
    	var uploadResult = $(".uploadResult");
    	var str ="";
    	$(uploadResultArr).each(function(obj){
    		if(obj.fileType) {	//True 이면
    			// 썸네일 이미지 경로
    			var filePath = encodeURIComponent(obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
    			// 원본 파일 이미지 경로
    			var oriPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
    			
    			// 폴더 구분의 \를 /로 바꾸는 작업
    			oriPath = oriPath.replace(new RegExp(/\\/g),"/");
    			str+="<span id = 'image_span' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'";
                str+=" data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
                str+="<img src='/reviewdisplay?fileName="+filePath+"' id ='img_px'></a>"; // 고정이미지값을 줄려고 id를 넣음
                str+="</span>";
    		}
    	});
    	var span_length = $(".uploadResult span").length;
    	console.log("span 갯수 : " + span_length);
    	
    	if(span_length === 4) {
    		alert("이미지는 4개까지 업로드 가능합니다.");
    		$("#uploadIMG").off("click");
    		return;
    	}
    	uploadResult.append(str);
    }
    
    // X를 클릭하면 첨부된 파일 삭제하기
    $(".uploadResult").on("click","button",function(){
        var targetFile=$(this).data("file");
        var type=$(this).data("type");
     
        // 첨부목록 삭제
        var targetLi=$(this).closest("li");
        
        
        // 가져온 데이터 서버로 전송
        $.ajax({
           url : '/deleteReviewFile',
           dataType : 'text',
           data:{
              fileName:targetFile,
              type:type
           },
           type:'post',
           success:function(result){
              console.log(result);
              targetLi.remove();
           }
        });
	});
});
</script>
</html>