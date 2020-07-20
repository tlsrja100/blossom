package com.blossom.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.ReviewDto;

@Repository
public class ReviewDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int reviewInsert(ReviewDto dto) {
		return sqlSessionTemplate.insert("reviewInsert",dto);
	}
}
