$(document).ready(function(){
	$(function(){
		var formObj = $("form[role='form']");
		$("button[type='submit']").click(function(e){
			e.preventDefault();
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
	       var targetFile=$(this).data("file");
	       var type=$(this).data("type");
	    
	       // 첨부목록 삭제
	       var targetLi=$(this).closest("div");
	       
	       
	       // 가져온 데이터 서버로 전송
	       $.ajax({
	          url : '/deleteFile',
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
})