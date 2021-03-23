package com.blossom.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blossom.dao.ReserveDao;
import com.blossom.dto.ReserveDto;

@Service
public class ReserveService {
	
	@Autowired
	private ReserveDao dao;
	
	public List<ReserveDto> timeList(String day, int dno) {
		return dao.timeList(day,dno);
	}
	
	public void reserveInsert(ReserveDto dto) {
		dao.reserveInsert(dto);
	}
}
