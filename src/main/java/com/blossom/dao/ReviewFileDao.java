package com.blossom.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.ReviewFileDto;

@Repository
public class ReviewFileDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int addFile(ReviewFileDto attach) {
		return sqlSessionTemplate.insert("addFile",attach);
	}
	
	public ReviewFileDto reviewList(int num) {
		return sqlSessionTemplate.selectOne("reviewList",num);
	}
	
	public List<ReviewFileDto> findByNum(int num) {
		return sqlSessionTemplate.selectList("findByNum",num);
	}

}
