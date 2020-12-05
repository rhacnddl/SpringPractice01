package org.practice.controller;

import org.practice.domain.ReplyVO;
import org.practice.mapper.BoardMapper;
import org.practice.mapper.ReplyMapper;
import org.practice.service.BoardService;
import org.practice.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = "/reply")
@PreAuthorize(value = "isAuthenticated()")
public class ReplyController {

	@Setter(onMethod_ = @Autowired)
	private ReplyService reply_service;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService board_service;
	
	
	@PostMapping("/write")
	@Transactional
	public String write(ReplyVO reply, RedirectAttributes rttr) {
		
		int bno = reply.getBno();
		
		log.info("=======================");
		log.info("@Service Reply Write : " + reply);
		log.info("=======================");
		
		if(Integer.toString(reply.getR_rno()) != null)
			reply_service.write_r(reply); //대댓글
		else
			reply_service.write(reply); //댓글
		
		board_service.hit_minus(bno); //조회수는 -1
		
		return "redirect:/board/get?bno=" + bno;
	}
	
	@PostMapping("/update")
	@Transactional
	public String update(ReplyVO reply, RedirectAttributes rttr) {
		
		int bno = reply.getBno();
		
		log.info("=======================");
		log.info("@Service Reply Update : " + reply);
		log.info("=======================");
		
		reply_service.update(reply);
		board_service.hit_minus(bno); //조회수는 -1
		
		return "redirect:/board/get?bno=" + bno;
	}
	
	@PostMapping("/remove")
	@Transactional
	public String remove(int rno, RedirectAttributes rttr) {
		
		int bno = reply_service.get(rno).getBno();
		
		log.info("=======================");
		log.info("@Service Reply Remove RNO : " + rno);
		log.info("=======================");
		
		reply_service.remove(rno);
		board_service.hit_minus(bno); //조회수는 -1
		
		return "redirect:/board/get?bno=" + bno;
	}
}
