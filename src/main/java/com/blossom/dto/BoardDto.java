package com.blossom.dto;

import java.util.Date;

public class BoardDto {

	private int num;
	private String title;
	private String writer;
	private String content;
	private Date regdate;
	
	
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "BoardDto [num=" + num + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", regdate=" + regdate + "]";
	}
	
	
}
