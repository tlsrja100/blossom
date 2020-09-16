package com.blossom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blossom.dao.AdminDao;
import com.blossom.dto.BlossomDto;

@Service
public class AdminService {

	@Autowired
	private AdminDao dao;
	
	public List<BlossomDto> list(String searchOption, String keyword, int start, int end){
		return dao.list(searchOption, keyword, start, end);
	}
	
	public int count(String searchOption, String keyword) {
		return dao.count(searchOption, keyword);
	}
}
