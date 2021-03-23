package com.blossom.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.ReserveDto;

@Repository
public class ReserveDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<ReserveDto> timeList(String day, int dno){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("day", day);
		map.put("dno", dno);
		return sqlSessionTemplate.selectList("timeList", map);
	}
	
	public void reserveInsert(ReserveDto dto) {
		sqlSessionTemplate.insert("reserveInsert",dto);
	}
}
