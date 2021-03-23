package com.blossom.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.DesignerDto;

@Repository
public class DesignerDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int designerInsert(DesignerDto dto) {
		return sqlSessionTemplate.insert("designerInsert",dto);
	}
	
	public List<DesignerDto> designerList() {
		return sqlSessionTemplate.selectList("designerList");
	}
	

}
