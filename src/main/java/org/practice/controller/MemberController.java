package org.practice.controller;

import org.practice.domain.MemberVO;
import org.practice.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
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
	
	
	@GetMapping("/home")
	@PreAuthorize("isAuthenticated()")
	public void home() {
		
		log.info("Welcome to HOME");
	}
	
	@GetMapping("/customLogin")
	public void customLogin(String error, String logout, Model model) {
		log.info("< Login >");
		
		if(error != null)
			model.addAttribute("error", error);
		if(logout != null)
			model.addAttribute("logout", logout);
		
		
	}
	@PostMapping("/customLogin")
	public String customLogin(MemberVO member, RedirectAttributes rttr) {
		
		log.info("Login : " + member);
		
		return "redirect:/home";
	}
	
	@GetMapping("/createAccount")
	public void createAccount() {
		log.info("Create Account");
	}
	@PostMapping("/createAccount")
	@Transactional
	public String createAccount(MemberVO member, RedirectAttributes redirect) {
		
		log.info("===================================");
		log.info("Create Account Info : " + member);
		log.info("Default Auth : 'Member'");
		log.info("===================================");
		
		service.createAccount(member);
		service.defaultAuth(member.getUserid());
		
		return "redirect:/customLogin";
	}
	
	@GetMapping("/accessDenied")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("Access Denied: " + auth);
		model.addAttribute("msg", "Access Denied!");
	}
}
