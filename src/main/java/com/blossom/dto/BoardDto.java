package com.blossom.dto;


public class BoardDto {

	private int num;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	
	
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
	public String setRegdate(String regdate) {
		return this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "BoardDto [num=" + num + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", regdate=" + regdate + "]";
	}
	
	
}
