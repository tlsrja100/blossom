package com.blossom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blossom.dao.DesignerDao;
import com.blossom.dto.DesignerDto;

@Service
public class DesignerService {

	@Autowired
	private DesignerDao dao;
	
	public boolean designerInsert(DesignerDto dto) {
		return dao.designerInsert(dto)==1;
	}
	
	public List<DesignerDto> designerList() {
		return dao.designerList();
	}
	

}
