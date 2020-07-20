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
	
	// 글 목록
	public List<BoardDto> boardList(String searchOption, String keyword, int start, int end){
		return dao.boardList(searchOption, keyword, start, end);
	}
	
	// 글 등록
	public void insert(BoardDto dto) {
		dao.insert(dto);
	}
	
	// 글 조회
	public BoardDto boardDetail(int num) {
		return dao.boardDetail(num);
	}
	
	// 글 수정
	public void boardModify(BoardDto dto) {
		dao.boardModify(dto);
	}
	
	// 글 삭제
	public void boardDelete(int num) {
		dao.boardDelete(num);
	}
	
	// 게시물 총 갯수
	public int boardCount(String searchOption, String keyword) {
		return dao.boardCount(searchOption, keyword);
	}
}
