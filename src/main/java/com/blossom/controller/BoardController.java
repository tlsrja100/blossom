package com.blossom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.blossom.dto.BoardDto;
import com.blossom.service.BoardService;

@RequestMapping("/board/*")
@Controller
public class BoardController {

	@Autowired
	private BoardService service;
	
	@GetMapping("/boardMain") 
	public ModelAndView boardmain() {
		ModelAndView mav = new ModelAndView();
		List<BoardDto> list = service.boardList();
		
		mav.setViewName("/board/boardMain");
		mav.addObject("boardList", list);
		
		return mav;
	}
}
