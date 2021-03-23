package com.blossom.dto;

import java.util.List;

public class DesignerDto {
	
	private Integer dno;
	private String designer_name;
	private String designer_memo;
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private List<DesignerDto> attachList;

	
	public Integer getDno() {
		return dno;
	}

	public void setDno(Integer dno) {
		this.dno = dno;
	}

	public String getDesigner_name() {
		return designer_name;
	}

	public void setDesigner_name(String designer_name) {
		this.designer_name = designer_name;
	}

	public String getDesigner_memo() {
		return designer_memo;
	}

	public void setDesigner_memo(String designer_memo) {
		this.designer_memo = designer_memo;
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

	public List<DesignerDto> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<DesignerDto> attachList) {
		this.attachList = attachList;
	}

	@Override
	public String toString() {
		return "DesignerDto [dno=" + dno + ", designer_name=" + designer_name + ", designer_memo=" + designer_memo
				+ ", uuid=" + uuid + ", uploadPath=" + uploadPath + ", fileName=" + fileName + ", fileType=" + fileType
				+ ", attachList=" + attachList + "]";
	}
	

}