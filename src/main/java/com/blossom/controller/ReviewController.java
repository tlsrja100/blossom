package com.blossom.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.blossom.common.ReviewPager;
import com.blossom.dto.BlossomDto;
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
	public ModelAndView getMain(@RequestParam(defaultValue = "1") int curPage) {
		log.info("reviewMain..");
		ModelAndView mav = new ModelAndView();
		int count = service.reviewCount();
		ReviewPager pager = new ReviewPager(count, curPage);
		
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<ReviewDto> reviewList = service.reviewList(start, end);
		System.out.println("reviewList" + reviewList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("reviewList", reviewList);
		map.put("start", start);
		map.put("end", end);
		map.put("pager", pager);
		map.put("count", count);
		mav.addObject("map", map);
		mav.setViewName("/review/reviewMain");
		return mav;

	}


	@GetMapping("/reviewInsert")
	public void getInsert() {
		log.info("get reviewInsert..");
	}

	@PostMapping("/reviewInsert")
	public String postInsert(ReviewDto dto) {
		log.info("=======================================");
		log.info("reviewInsert : " + dto);
		if (dto.getAttachList() != null) {
			dto.getAttachList().forEach(attach -> log.info("attach :", attach));
		}

		log.info("=======================================");
		service.reviewInsert(dto);

		return "redirect:reviewMain";
	}

	
	@GetMapping("/reviewDetail")
	public ModelAndView getDetail(@RequestParam int rno, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ReviewDto dto = service.reviewDetail(rno);
		ModelAndView mav = new ModelAndView();
		
		Cookie[] cookies = request.getCookies();
		
		// 비교하기 위해 새로운 쿠키
		Cookie viewCookie = null;
		
		// 쿠키가 있을 경우
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + rno 와 일치하는 쿠키를 viewCookie에 넣어줌
				if(cookies[i].getName().equals("cookie" + rno)) {
					System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
		if(dto != null) {
			System.out.println("해당 상세 리뷰페이지로 넘어감");
			mav.addObject("dto", dto);
			
			// 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리
			if(viewCookie == null) {
				System.out.println("cookie 없음");
				
				// 쿠키 생성 
				Cookie newCookie = new Cookie("cookie"+rno, "|" + rno + "|");
				
				// 쿠키 추가
				response.addCookie(newCookie);
				
				// 쿠키를 추가 시키고 조회수 증가시킴
				int result = service.readcnt(rno);
				
				if(result > 0) {
					System.out.println("조회수 증가");
				} else {
					System.out.println("조회수 증가 에러");
				}
			} else {
				System.out.println("cookie 있음");
				// 쿠키 값 받아옴
				String value = viewCookie.getValue();
				System.out.println("cookie 값 : " + value);
			}
			mav.setViewName("/review/reviewDetail");
			return mav;
		} else {
			mav.setViewName("/review/reviewDetail");
			return mav;
		}
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ReviewFileDto>> getAttachList(int rno) {
		log.info("getAttachList" + rno);
		return new ResponseEntity<>(service.getAttachList(rno), HttpStatus.OK);
	}

	
	@PostMapping("/reviewModify")
	public String modfy(ReviewDto dto, HttpServletRequest req) {
		log.info("modifyrno" + dto.getRno());
		service.reviewUpdate(dto);
		return "redirect:reviewMain";
	}
}
