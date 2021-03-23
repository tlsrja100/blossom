package com.blossom.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
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

import com.blossom.dto.DesignerDto;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Slf4j
public class DesignerUpload {
	
	@GetMapping("/designerAjax")
	public void designerAjax() {
		log.info("designerAjax 요청");
	}
	
	@PostMapping(value="/designerAjax",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<DesignerDto>> designerAjaxPost(MultipartFile[] uploadFile){
		log.info("ajax 파일 업로드 요청");
		String uploadFolder="d:\\upload\\designer";
		//년/월/일 폴더 형태로 가져오기
		String uploadFolderPath=getFolder();
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		//폴더가 없으면 새로 생성하기
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		List<DesignerDto> attList=new ArrayList<DesignerDto>();
		String uploadFileName="";
		
		for(MultipartFile f:uploadFile) {
			log.info("file Path : "+ uploadPath );
			log.info("file Name : "+f.getOriginalFilename());
			log.info("file Size : "+f.getSize());
			
			uploadFileName=f.getOriginalFilename();
			
			//uuid 값 생성 후 파일명과 함게 저장하기
			UUID uuid=UUID.randomUUID();
			uploadFileName=uuid.toString()+"_"+uploadFileName;
			File saveFile = new File(uploadPath,uploadFileName);
			log.info("upload file name  "+uploadFileName);
			//현재 파일의 저장경로와 파일명, 이미지 여부, uuid값을 담는 객체 생성
			DesignerDto attach=new DesignerDto();
			attach.setUuid(uuid.toString());
			attach.setUploadPath(uploadFolderPath);
			attach.setFileName(f.getOriginalFilename());
			
			if(checkImageType(saveFile)) {
				attach.setFileType(true);
				//썸네일 작업하기
				try {
					FileOutputStream thumbnail= new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(f.getInputStream(),thumbnail,200,200);
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
	@GetMapping("/designerDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("썸네일 이미지 가져오기");
		
		File file = new File("d:\\upload\\designer\\"+fileName);
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
	
	//폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
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
