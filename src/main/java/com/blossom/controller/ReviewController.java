package com.blossom.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.blossom.dto.ReviewDto;
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
		if(dto.getAttachList() != null) {
			for(ReviewDto attach : dto.getAttachList()) {
				log.info("attach" + attach);
			}
		}
		if(service.reviewInsert(dto)) {
			return "/review/reviewMain";
		}
		return "/review/reviewMain";
	}
}
