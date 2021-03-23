package com.blossom.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.blossom.controller.AjaxUploadController;
import com.blossom.dao.ReviewDao;
import com.blossom.dto.ReviewDto;
import com.blossom.dto.ReviewFileDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReviewService {

	@Autowired
	private ReviewDao reviewdao;

	@Transactional
	public void reviewInsert(ReviewDto dto) {
		reviewdao.reviewInsert(dto);
		System.out.println("rno : " + dto.getRno());

		if (dto.getAttachList() == null || dto.getAttachList().size() <= 0) {
			return;
		}

		dto.getAttachList().forEach(attach -> {
			attach.setRno(dto.getRno());
			reviewdao.fileUpload(attach);
		});
	}

	public List<ReviewFileDto> getAttachList(int rno) {
		return reviewdao.getAttachList(rno);
	}

	public List<ReviewDto> reviewList(int start, int end) {
		return reviewdao.reviewList(start, end);
	}

	public ReviewDto reviewDetail(int rno) {
		return reviewdao.reviewDetail(rno);
	}

	@Transactional
	public boolean reviewUpdate(ReviewDto dto) {
		log.info("modify..............." + dto);
		System.out.println("updaterno : " + dto.getRno());
		reviewdao.fileDelete(dto.getRno());
		boolean modifyResult = reviewdao.reviewUpdate(dto) == 1;
		
		if(modifyResult && dto.getAttachList() != null && dto.getAttachList().size() > 0) {
			dto.getAttachList().forEach(attach -> {
				attach.setRno(dto.getRno());
				reviewdao.fileUpload(attach);
				log.info("fileupload");
			});
		}
		return modifyResult;
	}
	
	public int reviewCount() {
		return reviewdao.reviewCount();
	}
	
	public int readcnt(int rno) {
		return reviewdao.readcnt(rno);
	}
}
