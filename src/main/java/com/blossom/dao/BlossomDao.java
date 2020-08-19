package com.blossom.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.blossom.dto.BlossomDto;

@Repository
public class BlossomDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	

	
	// 회원가입
	public void insert(BlossomDto dto) {
		sqlSessionTemplate.insert("insert",dto);
	}
	
	// 이메일 중복확인
	public BlossomDto checkEmail(String email) {
		return sqlSessionTemplate.selectOne("checkEmail",email);
	}
	
	// 로그인
	public BlossomDto login(BlossomDto dto) {
		return sqlSessionTemplate.selectOne("login",dto);
	}
	
	// 패스워드
	public BlossomDto getPw(String password) {
		return sqlSessionTemplate.selectOne("password", password);
	}
}
