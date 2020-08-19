package com.blossom.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.blossom.dto.ReviewDto;
import com.blossom.dto.ReviewFileDto;
import com.blossom.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/review/*")
@Controller
public class ReviewController {

	@Autowired
	private ReviewService service;
	
	@GetMapping("/reviewMain")
	public void getMain() {
		log.info("reviewMain..");
	}
	
	@GetMapping("/reviewInsert")
	public void getInsert() {
		log.info("get reviewInsert..");
	}
	
	
	@PostMapping("/reviewInsert")
	public String postInsert(ReviewDto dto) {
		log.info("post reviewInsert..");
		/*
		 * if(dto.getAttachList() != null) { for (ReviewFileDto attach :
		 * dto.getAttachList()) { log.info("attach " + attach); } }
		 */
		
		if (dto.getAttachList() != null) {
			for (ReviewFileDto attach : dto.getAttachList()) {
				log.info("attach" + attach);
				service.reviewInsert(dto);
			}
		}

		return "redirect:reviewMain";
	}
}
