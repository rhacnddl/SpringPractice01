package org.practice.controller;

import org.practice.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/board")
public class BoardController {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	
}
