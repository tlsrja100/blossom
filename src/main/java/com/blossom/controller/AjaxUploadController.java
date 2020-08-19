package com.blossom.controller;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.blossom.dto.ReviewDto;
import com.blossom.dto.ReviewFileDto;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Slf4j
public class AjaxUploadController {
	int number = 1;
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjax 요청");
	}
	
	@PostMapping(value="/uploadAjax",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ReviewFileDto>> uploadAjaxPost(MultipartFile[] uploadFile){
		log.info("ajax 파일 업로드 요청");
		String uploadFolder="d:\\upload\\review";
		//년/월/일 폴더 형태로 가져오기
		String uploadFolderPath=getFolder();
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		boolean bool = true;
		
		//폴더가 없으면 새로 생성하기
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		List<ReviewFileDto> attList=new ArrayList<ReviewFileDto>();
		String uploadFileName="";
		String uploadFileName2="";
		
		
		
		for(MultipartFile f:uploadFile) {
			bool = true;
			log.info("file Name : "+f.getOriginalFilename());
			log.info("file Size : "+f.getSize());
			
			uploadFileName=f.getOriginalFilename();
			uploadFileName2=f.getOriginalFilename();
			
			//uuid 값 생성 후 파일명과 함게 저장하기
			UUID uuid=UUID.randomUUID();
			
			while(bool) {
				uploadFileName = number + "_" + uuid.toString() + "_" + uploadFileName;

				/*
				 * if(number == 4) { bool = false; }
				 */
				if (number < 5) {
					number++;
				} else if (number == 4) {
					number = 1;
				}

				bool = false;
			}
		
			
			File saveFile = new File(uploadPath,uploadFileName);
			uploadFileName2=uuid.toString()+"_"+uploadFileName2;
			log.info("upload file name  "+uploadFileName);
			//현재 파일의 저장경로와 파일명, 이미지 여부, uuid값을 담는 객체 생성
			ReviewFileDto attach=new ReviewFileDto();
			attach.setUuid(uuid.toString());
			attach.setUploadPath(uploadFolderPath);
			log.info("origin : " + f.getOriginalFilename());
			attach.setFileName(f.getOriginalFilename());
			if(saveFile != null) {
				log.info("save File not null");
			}
			if(checkImageType(saveFile)) {
				attach.setFileType(true);
				//썸네일 작업하기
				try {
					FileOutputStream thumbnail= new FileOutputStream(new File(uploadPath,"s_"+uploadFileName2));
					Thumbnailator.createThumbnail(f.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			try {
				f.transferTo(saveFile);
				attList.add(attach);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}	
		return new ResponseEntity<>(attList,HttpStatus.OK);
	}
	
	//썸네일 이미지를 보여주는 작업
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("썸네일 이미지 가져오기");
		
		File file = new File("d:\\upload\\review\\"+fileName);
		ResponseEntity<byte[]> result = null;
		HttpHeaders header= new HttpHeaders();
		try {
			//Files.probeContentType : MIME타입 알아내기
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result=new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
		
	}
	
	//첨부파일 삭제
		@PostMapping("/deleteFile")
		public ResponseEntity<String> deleteFile(String fileName,String type){
			//type이 image라면 썸네일과 원본파일 삭제
			//type이 file 이라면 원본파일만 삭제
			log.info("첨부파일 삭제..."+type+" 파일명 : "+fileName);
			
			try {
				File file=new File("d:\\upload\\review\\"+URLDecoder.decode(fileName, "utf-8"));
				//썸네일 이미지 or 일반 파일삭제
				file.delete();
				
				if(type.equals("image")) {
					//원본이미지 삭제
					String name=file.getAbsolutePath().replace("s_", "");
					file=new File(name);
					file.delete();
				}
			
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
			
			return new ResponseEntity<String>("deleted",HttpStatus.OK);
		}
		
	
	//폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	//파일이 이미지인지 확인하는 메소드
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
}








