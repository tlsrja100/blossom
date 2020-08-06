$(function(){
	var formObj = $("form[role='form']");
	$("button[type='submit']").click(function(e){
		e.preventDefault();
		
		// 첨부파일내용 : uuid, uploadPath, fileType, fileName
	     //=> fileDrop ul li가 가지고 있기 때문에 그 영역에 있는 값 수집하기
		var str = "";
		$(".fileDrop").each(function(i){
			var job = $(".fileDrop div");
			str+="<input type='hidden' name='reviewDto["+i+"].uuid' value='"+job.data("uuid")+"'>";
	        str+="<input type='hidden' name='reviewDto["+i+"].uploadPath' value='"+job.data("path")+"'>";
	        str+="<input type='hidden' name='reviewDto["+i+"].fileName' value='"+job.data("filename")+"'>";
	        str+="<input type='hidden' name='reviewDto["+i+"].fileType' value='"+job.data("type")+"'>";
		});
		console.log(str);
		formObj.append(str).submit();
	});
	
	// uploadImg 클릭하면 uploadFile에 있는 정보 가져오기 
	$("#uploadImg").click(function(){
		console.log("등록하기 버튼 클릭");
		var formData = new FormData();
		// file안에 들어잇는 여러개의 첨부된 파일 가져오기
		var inputFile=$("input[name='uploadFile']");
		var files=inputFile[0].files;
		
		for(var i=0; i < files.length;i++){
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			} else if (files.length > 4) {
				alert("이미지는 4개까지 등록 가능합니다.");
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		// formData를 ajax 사용해서 서버로 전송하기
		$.ajax({
			url : "/uploadAjax",
			data : formData,
			processData : false,   // formData를 쓸때 무조건 필요함(데이터를 어떤방식으로 변환할 것인지 결정)
            contentType : false,   // formData를 쓸때 무조건 필요함(formData가 기본적으로  application/x-www-form-urlencoded인 상황이라 false로 지정)
            type :"post",
            dataType : "json",      // 되돌아오는 데이터 타입 (전송이 잘 되면 success라는 문자열을 전송받을 예쩡)
            success:function(result) {
               console.log(result);   // 브라우저에 찍힌 파일내용
               showUploadedFile(result);
            }
		});
	});	//#uploadImg 종료
	
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
    function showUploadedFile(uploadResultArr) {
    	// 결과 보여줄 영역
    	var uploadResult = $(".fileDrop");
    	console.log(uploadResult);
    	var str="";
    	$(uploadResultArr).each(function(i,obj){
    		if(obj.fileType) {
    			//썸네일 이미지 경로
                var filePath=encodeURIComponent(obj.uploadPath+"\\s_"+obj.uuid+"_"+obj.fileName);
                 //원본 파일 이미지 경로
                var oriPath=obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
                
                //폴더 구분의 \를 /로 바꾸는 작업
                oriPath=oriPath.replace(new RegExp(/\\/g),"/");
                str+="<div id = 'image_span' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'";
                str+=" data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
                str+="<img src='/display?fileName="+filePath+"' id ='img_px'>"; // 고정이미지값을 줄려고 id를 넣음
                str+="<span data-file='"+filePath+"' data-type='image'> X </span></div>";
    		}
    	});
    	var span_length = $(".fileDrop div").length;
    	console.log("div갯수 : " , span_length);
    	
    	if(span_length === 4) {
    		alert("이미지는 4개까지 업로드 가능합니다.");
    		$("#uploadImg").off('click');
    		return;
    	}
    	uploadResult.append(str);
    }
 // X를 클릭하면 첨부된 파일 삭제하기
    $(".fileDrop").on("click","span",function(){
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