package com.blossom.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.blossom.dto.BlossomDto;
import com.blossom.service.BlossomService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/blossom/*")
@Controller
public class BlossomController {
	
	@Autowired
	private BlossomService service;
	
	
	 @GetMapping("/mainpage")
	 public void main() {
		 log.info("mainpage"); 
	}
	 
	
	// 회원가입 get
	@GetMapping("/joinpage")
	public void getJoinPage() {
		//return "/blossom/joinpage";
	}

	// 회원가입 post
	@PostMapping("/joinpage")
	public String postJoinPage(BlossomDto dto) {
		log.info("회원 가입");
		// BCrypt.hashpw() 메서드는 첫번째 파라미터에는 암호화할 비밀번호 두번째 파라미터는 BCrypt.getsalt()를 받고 암호화된 비밀번호를 리턴 해준다.
		String hashedPw = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt());
		dto.setPassword(hashedPw);
		service.insert(dto);
		return "redirect:mainpage";
	}
	
	// 로그인 get
	@GetMapping("/login")
	public void login() {
		log.info("login get");
	}	
	
	// 로그인 post
	@PostMapping("/login")
	public void loginPost(BlossomDto dto, HttpSession session, Model model, HttpServletRequest req, RedirectAttributes rttr) {
		log.info("login post.");
		BlossomDto login = service.login(dto);
		session = req.getSession();
		
		if (login == null || !BCrypt.checkpw(dto.getPassword(), login.getPassword())) {
			session.setAttribute("login", null);
			rttr.addFlashAttribute("msg",false);
			return;
		} else {
			session.setAttribute("login", login);
		}
		//model.addAttribute("user",login); 
		//return "redirect:/blossom";


	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("로그아웃");
		service.logout(session);
		return "redirect:mainpage";
	}
	
	
	
	@ResponseBody
	@PostMapping("/checkEmail")
	public String checkEmail(String email) {
		BlossomDto checkEmail = service.checkEmail(email);
		if(checkEmail != null) {
			log.info("이미 가입된 email 입니다.");
			return "false";
		} else {
			log.info("사용 가능한 email 입니다.");
			return "true";
		}
	}
	

}
