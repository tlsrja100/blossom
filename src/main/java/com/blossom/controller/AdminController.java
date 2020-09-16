package com.blossom.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.blossom.common.Pager;
import com.blossom.dto.BlossomDto;
import com.blossom.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminController {

	@Autowired
	private AdminService service;
	
	/*
	 * @GetMapping("/adminpage") public void getadmin() { log.info("get adminpage");
	 * }
	 */
	
	@GetMapping("/adminpage")
	public ModelAndView getAdmin(@RequestParam(defaultValue = "all") String searchOption,
								  @RequestParam(defaultValue = "") String keyword,
								  @RequestParam(defaultValue = "1") int curPage) {
		
		int count = service.count(searchOption, keyword);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<BlossomDto> list = service.list(searchOption, keyword, start,end);

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/adminpage");
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);
		mav.addObject("pager",pager);
		mav.addObject("count",count);
		mav.addObject("list",list);
		return mav;
	}
	
	@PostMapping("/adminpage")
	public ModelAndView postAdmin(@RequestParam(defaultValue = "all") String searchOption,
								  @RequestParam(defaultValue = "") String keyword,
								  @RequestParam(defaultValue = "1") int curPage) {
		
		int count = service.count(searchOption, keyword);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<BlossomDto> list = service.list(searchOption, keyword, start,end);

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/adminpage");
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);
		mav.addObject("pager",pager);
		mav.addObject("count",count);
		mav.addObject("list",list);
		return mav;
	}
	
	@GetMapping("/memberlist")
	public void getmemberlist() {
		log.info("get memberlist");
	}
}
