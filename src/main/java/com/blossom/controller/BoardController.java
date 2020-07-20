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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.blossom.common.Pager;
import com.blossom.dto.BoardDto;
import com.blossom.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board/*")
@Controller
public class BoardController {

	@Autowired
	private BoardService service;
	
	// Get 게시글 목록
	@GetMapping("/boardMain")
	public ModelAndView getmain(@RequestParam(defaultValue = "title") String searchOption,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "1") int curPage) {
		
		//게시물의 갯수
		int count = service.boardCount(searchOption, keyword);
		
		Pager pager = new Pager(count, curPage);
		
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<BoardDto> list = service.boardList(searchOption, keyword, start, end);
		
		ModelAndView mav = new ModelAndView();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("searchOption",searchOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("count", count);
		map.put("end", end);
		map.put("pager", pager);
		
		
		mav.setViewName("/board/boardMain");
		mav.addObject("map", map);
		
		return mav;
	}
	
	// 게시글 목록
	@PostMapping("/boardMain") 
	public ModelAndView boardmain(@RequestParam(defaultValue = "title") String searchOption,
									@RequestParam(defaultValue = "") String keyword,
									@RequestParam(defaultValue = "1") int curPage) {
		
		//게시물의 갯수
		int count = service.boardCount(searchOption, keyword);
		
		Pager pager = new Pager(count, curPage);
		
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<BoardDto> list = service.boardList(searchOption, keyword, start, end);

		ModelAndView mav = new ModelAndView();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("searchOption",searchOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("count", count);
		map.put("end", end);
		map.put("pager", pager);
		
		
		mav.setViewName("/board/boardMain");
		mav.addObject("map", map);
		
		return mav;
	}
	
	// Get 게시글 작성화면
	@GetMapping("/boardInsert")
	public void getInsert() {
		log.info("get Insert");
	}
	
	// Post 게시글 작성화면
	@PostMapping("/boardInsert")
	public void postInsert(BoardDto dto) {
		log.info("post Insert");
		service.insert(dto);
	}
	
	// Get 게시글 상세내용
	@GetMapping("/boardDetail")
	public ModelAndView getDetail(int num,BoardDto dto) {
		log.info("board Detail");
		System.out.println(dto.toString());
		return new ModelAndView("/board/boardDetail", "boardDto" ,service.boardDetail(num));
	}
	
	// Post 게시글 수정
	@ResponseBody
	@PostMapping("/boardModify")
	public void postModify(BoardDto dto) {
		log.info("modify");
		service.boardModify(dto);
	}
	
	// Post 게시글 삭제
	@ResponseBody
	@PostMapping("/boardDelete")
	public void postDelete(int num) {
		log.info("delete");
		service.boardDelete(num);
	}
}
