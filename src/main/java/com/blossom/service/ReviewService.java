package com.blossom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.blossom.dao.ReviewDao;
import com.blossom.dao.ReviewFileDao;
import com.blossom.dto.ReviewDto;
import com.blossom.dto.ReviewFileDto;

@Service
public class ReviewService {

	@Autowired
	private ReviewDao reviewdao;
	
	@Autowired
	private ReviewFileDao reviewFiledao;

	
	@Transactional 
	public void reviewInsert(ReviewDto dto) {
		reviewdao.reviewInsert(dto);

		// 파일 첨부 등록
		if (dto.getAttachList() == null || dto.getAttachList().size() <= 0) {
			return;
		}

		for (ReviewFileDto attach : dto.getAttachList()) {
			attach.setNum(dto.getNum());
			reviewFiledao.addFile(attach);
		}
	}

	public List<ReviewFileDto> findByNum(int num) {
		return reviewFiledao.findByNum(num);
	}

	public ReviewFileDto reviewList(int num) {
		return reviewFiledao.reviewList(num);
	}
	
	
	/*
	 * @Transactional public void reviewInsert(ReviewDto dto) {
	 * if(dto.getAttachList() == null || dto.getAttachList().size() <= 0) { return;
	 * } for(ReviewDto attach : dto.getAttachList()) {
	 * reviewdao.reviewInsert(attach); } }
	 */

}
