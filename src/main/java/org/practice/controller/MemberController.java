package org.practice.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.practice.domain.AuthVO;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Log4j
public class MemberController {

	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	
	@GetMapping("/home")
	@PreAuthorize(value = "isAuthenticated()")
	public void home() {
		
		log.info("Welcome to HOME");
	}
	
	@GetMapping("/customLogin")
	public void customLogin(String error, String logout, Model model) {
		log.info("< Login >");
		
		if(error != null)
			model.addAttribute("error", "Login Error Check your Account");
		if(logout != null)
			model.addAttribute("logout", "Logout!");
		
		
	}
	@PostMapping("/customLogin")
	public String customLogin(MemberVO member, RedirectAttributes rttr) {
		
		log.info("Login : " + member);
		
		return "redirect:/home";
	}
	
	@PostMapping("/customLogout")
	public String logout(String logout, RedirectAttributes rttr) {
		
		log.warn("===================================");
		log.warn("# Logout Success..." + logout);
		
		return "redirect:/customLogin";
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
	
	@GetMapping("/admin/grant")
	@PreAuthorize("hasRole('ADMIN')")
	public void grant(Model model) {
		
		log.info("===================================");
		log.info("@Controller, Admin Grant");
		
		model.addAttribute("auth", service.memberList());
	}
	
	@PostMapping("/admin/grant")
	@PreAuthorize("hasRole('ADMIN')")
	public String grant_post(AuthVO auth, RedirectAttributes rttr) {
		
		log.info("===================================");
		log.info("@Controller, Grant_Post");
		log.info("AuthVO : " + auth);
		
		if(!service.memberGrant(auth)) //성공하면 -1이 return된다. Why?
			log.info("Update Request was Success");
		else
			log.info("Update Request was Fail, try again");
		
		log.info("===================================");
		
		return "redirect:/admin/grant";
	}
	
	@GetMapping("/member/info")
	@PreAuthorize("principal.username == #userid")
	public void info(@Param("userid") String userid, Model model) {
		
		log.info("==============================");
		log.info("@Controller, Member Read By User ID : " + userid);
		log.info("==============================");
		
		model.addAttribute("member", service.read(userid));
	}
	
	@PostMapping("/member/info")
	//@PreAuthorize("principal.username == #userid")
	public String info_Post(MemberVO member, RedirectAttributes rttr) {
		
		log.info("==============================");
		log.info("@Controller, Member's Info Change Request : " + member);
		log.info("==============================");
		
		service.update(member);
		
		return "redirect:/member/info?userid=" + member.getUserid();
	}
}
