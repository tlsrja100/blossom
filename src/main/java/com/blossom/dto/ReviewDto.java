package com.blossom.dto;

import java.util.List;

public class ReviewDto {

	private int num;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private List<ReviewDto> attachList;
	
	public List<ReviewDto> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<ReviewDto> attachList) {
		this.attachList = attachList;
	}
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
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public boolean isFileType() {
		return fileType;
	}
	public void setFileType(boolean fileType) {
		this.fileType = fileType;
	}
	@Override
	public String toString() {
		return "ReviewDto [num=" + num + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", regdate=" + regdate + ", uuid=" + uuid + ", uploadpath=" + uploadPath + ", filename=" + fileName
				+ ", filetype=" + fileType + "]";
	}
	
	
	
	
}
