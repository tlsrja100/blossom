package com.blossom.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UploadController {
	
	/*
	 * @GetMapping("/uploadAjax") public void uploadAjax() {
	 * log.info("uploadAjax 요청"); }
	 */
	@PostMapping(value="/uploadSummernoteImageFile",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public void uploadAjaxPost(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("ajax 파일 업로드 요청");
		String uploadFolder="d:\\upload\\review";
		//년/월/일 폴더 형태로 가져오기
		String uploadFolderPath=getFolder();
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		//폴더가 없으면 새로 생성하기
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		
		String uploadFileName=file.getOriginalFilename();
			
			
		// uuid 값 생성 후 파일명과 함게 저장하기
		UUID uuid = UUID.randomUUID();

		uploadFileName = uuid.toString() + "_" + uploadFileName;
		File saveFile = new File(uploadPath, uploadFileName);
		log.info("upload file name  " + uploadFileName);
		// 현재 파일의 저장경로와 파일명, 이미지 여부, uuid값을 담는 객체 생성
		file.transferTo(saveFile);
	}

	//폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	

}
