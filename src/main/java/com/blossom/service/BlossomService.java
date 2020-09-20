package com.blossom.service;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.blossom.dao.BlossomDao;
import com.blossom.dto.BlossomDto;

@Service
public class BlossomService {

	@Autowired
	private BlossomDao dao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	// 회원가입
	public void insert(BlossomDto dto) {
		dao.insert(dto);
	}
	
	// 이메일 중복 확인
	public BlossomDto checkEmail(String email) {
		return dao.checkEmail(email);
	}
	
	// 로그인
	public BlossomDto login(BlossomDto dto) {
		return dao.login(dto);
	}
	
	// 로그아웃
	public void logout(HttpSession session) {
		session.invalidate();
	}
	
	// 회원정보
	public BlossomDto userinfo(String email) {
		return dao.userinfo(email);
	}
	
	// 회원정보수정
	public int modify(BlossomDto dto) {
		return dao.modify(dto);
	}
	
}
