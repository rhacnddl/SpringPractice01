package org.practice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController {

	@GetMapping("/customLogin")
	public void customLogin() {
		log.info("Welcome!");
	}
	
	@GetMapping("/createAccount")
	public void account() {
		log.info("Create Account");
	}
}
