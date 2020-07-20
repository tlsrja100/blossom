package com.blossom.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.BoardDto;

@Repository
public class BoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 글 목록
	public List<BoardDto> boardList(String searchOption, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("start",start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("boardList",map);
	}
	
	// 글 등록
	public void insert(BoardDto dto) {
		sqlSessionTemplate.insert("insertboard",dto);
	}
	
	// 글 조회
	public BoardDto boardDetail(int num) {
		return sqlSessionTemplate.selectOne("boardDetail",num);
		
	}
	
	// 글 수정
	public void boardModify(BoardDto dto) {
		sqlSessionTemplate.update("boardModify", dto);
	}
	
	// 글 삭제
	public void boardDelete(int num) {
		sqlSessionTemplate.delete("boardDelete", num);
	}
	
	// 글 count
	public int boardCount(String searchOption, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		return sqlSessionTemplate.selectOne("count",map);
	}
}
