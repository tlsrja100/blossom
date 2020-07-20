package com.blossom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blossom.dao.ReviewDao;
import com.blossom.dto.ReviewDto;

@Service
public class ReviewService {

	@Autowired
	private ReviewDao dao;
	
	public boolean reviewInsert(ReviewDto dto) {
		return dao.reviewInsert(dto) == 1;
	}
}
