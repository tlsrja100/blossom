package com.blossom.dto;

import java.util.List;

public class ReviewDto {

	private int num;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	
	// 파일 첨부 목록

	
	private List<ReviewFileDto> attachList;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public List<ReviewFileDto> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<ReviewFileDto> attachList) {
		this.attachList = attachList;
	}

	@Override
	public String toString() {
		return "ReviewDto [num=" + num + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", regdate=" + regdate + ", attachList=" + attachList + "]";
	}
	
	
	
	
	
	
}
