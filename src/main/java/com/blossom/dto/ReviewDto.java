package com.blossom.dto;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReviewDto {

	private int rno;
	private String title;
	private String writer;
	private String content;
	private Date regdate;
	private int readcnt;
	private List<ReviewFileDto> attachList;
	
	
	
	
	
}
