package com.blossom.controller;

import java.beans.PropertyEditorSupport;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.blossom.common.Pager;
import com.blossom.dto.BlossomDto;
import com.blossom.dto.DesignerDto;
import com.blossom.service.AdminService;
import com.blossom.service.DesignerService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminController {

	@Autowired
	private AdminService service;
	@Autowired
	private DesignerService dservice;

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
	
	@GetMapping("/designerPage")
	public ModelAndView getDesignerPage(Model model, HttpServletRequest request) {
		log.info("get Designer");
		List<DesignerDto> list = dservice.designerList();
		System.out.println("list  정보  : " + list);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("/admin/designerPage");
		return mav;
	}
	
	
	@GetMapping("/designerModal")
	public void getDesignerModal() {
		log.info("get designerModal");
	}
	
	@PostMapping("/designerModal")
	public String postDesignerModal(DesignerDto dto, Model model, RedirectAttributes rttr,HttpServletRequest request) {
		log.info("디자이너 정보", dto.toString());
		dservice.designerInsert(dto);
		//model.addAttribute("dto", dto);
		return "redirect:designerPage";
	}
	


}
