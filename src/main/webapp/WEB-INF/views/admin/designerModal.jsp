<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#in {
	float: right;
	margin-right: 30px;
}

#name {
	width: 335px;
	height: 34px;
}

#Memo {
	width: 335px;
	height: 200px;
}

#plusImg {
	margin-top: 70px;
	width: 50px;
	height: 50px;
}
#imgdiv {
	border-radius: 15px;
	margin-left: 15px;
	margin-top: 25px;
	text-align: center;
	float: left;
	border: 1px solid black;
	width: 200px;
	height: 200px;
}
#imgdiv li {
	list-style :none;
}

#photoUpload:before {
	content: '';
	height: 100%;
	display: inline-block;
	vertical-align: middle;
}

#photoUpload {
	background: #1AAB8A;
	color: #fff;
	border: none;
	position: relative;
	height: 40px;
	/* font-size: 1.6em; */
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
}

#photoUpload:hover {
	background: #fff;
	color: #1AAB8A;
}

#photoUpload:before, #photoUpload:after {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #1AAB8A;
	transition: 400ms ease all;
}

#photoUpload:after {
	right: inherit;
	top: inherit;
	left: 0;
	bottom: 0;
}

#photoUpload:hover:before, #photoUpload:hover:after {
	width: 100%;
	transition: 800ms ease all;+
}
</style>
<body>
	<div class="modal fade" id="designerModal" tabindex="1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" >
			<div class="modal-content" style="height:auto; min-height: 60%; width:650px;">
				<!-- Modal Header -->
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" >&times;</button>
					<h4 class="modal-title" id="myModalLabel" >직원추가</h4>
				</div><br />
				<!-- Modal body -->
				<div class="modal-body" style="height: 350px; ">
					<form action="/admin/designerModal" method="post" role="form" enctype="multipart/form-data" id="designerForm">
						<div id="imgdiv">
							<input type="file" name="uploadFile" id="file" style="display:none;" />
							<img src="../resources/img/plus.png" id="plusImg" />
						</div>
							<div id="in">
								<label for="name">이름</label><br />
								<input class="form-control" type="text" name="designer_name" id="name" placeholder="이름" /><br />
							</div>
							<div id="in">
								<label for="Memo">Memo</label><br />
								<textarea rows="2" cols="50" wrap="hard" class="form-control" name="designer_memo" id="Memo" placeholder="Memo" ></textarea>
							</div>
							<button type="button" id="photoUpload" style="margin-left:55px; margin-top:35px; float:left;" onclick="onclick=document.all.file.click()">사진업로드</button>
					</form>
				</div>

				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" style="margin-right:25px;">추가하기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
$(document).ready(function(){
	$(function(){
		var formObj=$("form[role='form']");
		$("button[type='submit']").click(function(e){
			e.preventDefault();
			var str="";
			var job=$("#imgdiv li");
			str+="<input type='hidden' name='uuid' value='"+job.data("uuid")+"'>";
			str+="<input type='hidden' name='uploadPath' value='"+job.data("path")+"'>";
			str+="<input type='hidden' name='fileName' value='"+job.data("filename")+"'>";
			str+="<input type='hidden' name='fileType' value='"+job.data("type")+"'>";
			console.log(str);
			formObj.append(str).submit();
		});
		$("input[type='file']").change(function(){
			var formData = new FormData();
			var inputFile=$("input[name='uploadFile']");
			var files=inputFile[0].files;
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i].name,files[i].size)){
					return false;
				}
				formData.append("uploadFile",files[i]);
			}
			$.ajax({
				url : "/designerAjax",
				data : formData,
				processData : false,
				contentType : false,
				type : "post",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadedFile(result);
				}
			});
		});
		function checkExtension(fileName,fileSize){
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; //5MB
			
			if(fileSize>maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 파일의 확장자는 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}	
		function showUploadedFile(obj){
			var uploadResult = $("#imgdiv");
			var str="";
			/* if(obj[0].fileType) {
				var filePath=encodeURIComponent(obj[0].uploadPath+"\\s_"+obj[0].uuid+"_"+obj[0].fileName);					
				str+="<div data-path='"+obj[0].uploadPath+"' data-uuid='"+obj[0].uuid+"'";
				str+=" data-filename='"+obj[0].fileName+"' data-type='"+obj[0].fileType+"'";
				str+=">";		
				str+="<img src='/designerDisplay?fileName="+filePath+"' style='width:200px;height:200px; border-radius:15px;'>";
				str+="<span data-file='"+filePath+"' data-type='image'></span></div>";
			}
			uploadResult.html(str); */
			if(obj[0].fileType){//true이면 이미지
				//썸네일 이미지 경로
				var filePath=encodeURIComponent(obj[0].uploadPath+"\\s_"+obj[0].uuid+"_"+obj[0].fileName);					
				
				str+="<li data-path='"+obj[0].uploadPath+"' data-uuid='"+obj[0].uuid+"'";
				str+=" data-filename='"+obj[0].fileName+"' data-type='"+obj[0].fileType+"'";
				str+=">";					
				str+="<img src='/designerDisplay?fileName="+filePath+"' style='width:200px;height:200px; border-radius:15px;'>";
				str+="</li>";
			}
		uploadResult.html(str);
		};
	})
})
var sel_file;
$(document).ready(function(){
	$("#file").on("change",fileChange);
});
function fileChange(e) {
	e.preventDefault();


	var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);

    filesArr.forEach(function(f) {
        if(!f.type.match("image.*")) {
            alert("확장자는 이미지 확장자만 가능합니다.");
            return;
        }

        sel_file = f;

        var reader = new FileReader();
        reader.onload = function(e) {
            $("#plusImg").attr("src", e.target.result);
        	//$(".photo").css("height", "100px")
        }
        reader.readAsDataURL(f);
    }); 
} 
</script>
</html>