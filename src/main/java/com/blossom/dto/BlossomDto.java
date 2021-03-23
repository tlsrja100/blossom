package com.blossom.dto;

import java.util.Date;



public class BlossomDto {
	private int cno;
	private String email;
	private String password;
	private String name;
	private String birth;
	private String gender;
	private String phone;
	private String addr1;
	private String addr2;
	private String addr3;
	private Date regDate;
	private int grade;
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getAddr3() {
		return addr3;
	}
	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "BlossomDto [cno=" + cno + ", email=" + email + ", password=" + password + ", name=" + name + ", birth="
				+ birth + ", gender=" + gender + ", phone=" + phone + ", addr1=" + addr1 + ", addr2=" + addr2
				+ ", addr3=" + addr3 + ", regDate=" + regDate + ", grade=" + grade + ", getCno()=" + getCno()
				+ ", getEmail()=" + getEmail() + ", getPassword()=" + getPassword() + ", getName()=" + getName()
				+ ", getBirth()=" + getBirth() + ", getGender()=" + getGender() + ", getPhone()=" + getPhone()
				+ ", getAddr1()=" + getAddr1() + ", getAddr2()=" + getAddr2() + ", getAddr3()=" + getAddr3()
				+ ", getRegDate()=" + getRegDate() + ", getGrade()=" + getGrade() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	
	
	
	
}
