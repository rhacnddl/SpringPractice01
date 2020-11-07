package org.practice.controller;

import org.practice.domain.MemberVO;
import org.practice.mapper.MemberMapper;
import org.practice.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController {

	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	
	@GetMapping("/customLogin")
	public void customLogin() {
		log.info("Welcome!");
	}
	
	@GetMapping("/createAccount")
	public void createAccount() {
		log.info("Create Account");
	}
	@PostMapping("/createAccount")
	public String createAccount(MemberVO member, RedirectAttributes redirect) {
		
		log.info("===================================");
		log.info("Create Account Info : " + member);
		log.info("===================================");
		
		service.createAccount(member);
		
		return "redirect:/customLogin";
	}
}
