package org.practice.controller;

import java.util.List;

import org.practice.domain.BoardVO;
import org.practice.domain.Pager;
import org.practice.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;

@RestController("apiController")
@RequestMapping(value="/api", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
public class APIController {

	@Autowired
	BoardService service;
	
	@GetMapping("/list")
	public List<BoardVO> list(){
		
		return service.getList(101, new Pager());
	}
}
