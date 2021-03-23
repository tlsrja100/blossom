package com.blossom.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blossom.dto.DesignerDto;
import com.blossom.dto.ReserveDto;
import com.blossom.service.DesignerService;
import com.blossom.service.ReserveService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/reserve/*")
@Controller
public class ReserveController {

	@Autowired
	private DesignerService dservice;
	@Autowired
	private ReserveService rservice;


	@GetMapping("/reserveMain")
	public void getReserveMain(Model model) {
		log.info("예약메인page..");
		List<DesignerDto> list = dservice.designerList();
		model.addAttribute("list", list);
	}

	@ResponseBody
	@PostMapping("/reserve")
	public void postReserve(ReserveDto dto) {
		rservice.reserveInsert(dto);
	}
	
	@ResponseBody
	@PostMapping("/timeCheck")
	public Map<String, Object> timeCheck(String day,int dno, Model model) {
		// String month = request.getParameter("month");
		Map<String, Object> result = new HashMap<String, Object>();
		List<ReserveDto> timeList = rservice.timeList(day,dno);
		if (timeList != null) {
			System.out.println(dno);
			System.out.println(day);
			System.out.println("timeList : " + timeList);
			result.put("timeList", timeList);
			result.put("day", day);
			result.put("dno", dno);
			return result;
		} else {
			return result;
		}
	}

}
