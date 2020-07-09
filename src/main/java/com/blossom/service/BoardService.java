package com.blossom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.blossom.dao.BoardDao;
import com.blossom.dto.BoardDto;

@Service
public class BoardService {

	@Autowired
	private BoardDao dao;
	
	public List<BoardDto> boardList(){
		return dao.boardList();
	}
}
