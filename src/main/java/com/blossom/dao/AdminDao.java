package com.blossom.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.BlossomDto;

@Repository
public class AdminDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 회원목록 출력
	public List<BlossomDto> list(String searchOption, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		return sqlSessionTemplate.selectList("MemberList", map);
	};
	
	
	
	
	// 회원 count
	public int count(String searchOption, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		return sqlSessionTemplate.selectOne("MemberCount", map);
	}
	
	
}
