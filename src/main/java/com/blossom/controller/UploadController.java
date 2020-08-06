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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.blossom.dto.ReviewDto;
import com.blossom.dto.ReviewFileDto;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Slf4j
public class UploadController {
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjax 요청");
	}
	
	@PostMapping(value="/uploadAjax",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Map<String, Object>> uploadAjaxPost(MultipartHttpServletRequest request,ReviewDto dto) throws Exception {
		log.info("ajax 파일 업로드 요청");
		String uploadFolder="d:\\upload\\review";
		//년/월/일 폴더 형태로 가져오기
		String uploadFolderPath=getFolder();
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		Iterator<String> iterator = request.getFileNames();
		//폴더가 없으면 새로 생성하기
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		int num = dto.getNum();
		
		MultipartFile multipartFile = null;
		String uploadFileName= null;
		
		while(iterator.hasNext()) {
			multipartFile = request.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				uploadFileName = multipartFile.getOriginalFilename();
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString()+"_"+uploadFileName;
				
				File saveFile = new File(uploadPath,uploadFileName);
				multipartFile.transferTo(saveFile);
				listMap = new HashMap<String, Object>();
				listMap.put("num", num);
				listMap.put("uuid", uuid);
				listMap.put("uploadPath", uploadPath);
				listMap.put("fileName", uploadFileName);
				listMap.put("File_size", multipartFile.getSize());
				list.add(listMap);
				ReviewFileDto attach = new ReviewFileDto();
				if(checkImageType(saveFile)) {
					attach.setFileType(true);
					//썸네일 작업하기
					try {
						FileOutputStream thumbnail= new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
						Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
						thumbnail.close();
					} catch (FileNotFoundException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return list;
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








