package com.blossom.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.ReviewDto;
import com.blossom.dto.ReviewFileDto;


@Repository
public class ReviewDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public void reviewInsert(ReviewDto dto) {
		sqlSessionTemplate.insert("InsertSelectKey", dto);
	}
	
	public void fileUpload(ReviewFileDto dto) {
		sqlSessionTemplate.insert("fileUpload", dto);
	}
	
	
	public List<ReviewFileDto> getAttachList(int rno) {
		return sqlSessionTemplate.selectList("findByRno", rno);
	}
	
	public List<ReviewDto> reviewList(int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("reviewList", map);
	}
	
	public ReviewDto reviewDetail(int rno) {
		return sqlSessionTemplate.selectOne("reviewDetail", rno);
	}
	
	public int reviewUpdate(ReviewDto dto) {
		return sqlSessionTemplate.update("reviewUpdate", dto) ;
	}
	
	public void fileDelete(int rno) {
		sqlSessionTemplate.delete("fileDelete",rno);
	}
	
	public int reviewCount() {
		return sqlSessionTemplate.selectOne("reviewCount");
	}
	
	public int readcnt(int rno) {
		return sqlSessionTemplate.update("readCnt", rno);
	}
}
