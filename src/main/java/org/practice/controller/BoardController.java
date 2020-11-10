package org.practice.controller;

import java.util.List;

import org.practice.domain.BoardVO;
import org.practice.service.BoardService;
import org.practice.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/board")
@PreAuthorize("isAuthenticated()")
public class BoardController {

	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyService reply_service;
	
	
	@GetMapping("/list")
	public void list(int div, Model model) {
		
		log.info("=============== Board Controller ====================");
		model.addAttribute("list", service.getList(div));
		model.addAttribute("division", div);
	}
	
	@GetMapping("/write")
	public void write(int div, Model model) {
		
		log.info("# Board Write Page");
		model.addAttribute("division", div);
	}
	@PostMapping("/write")
	public String write(BoardVO board, RedirectAttributes rttr) {
		
		log.info("@Controller - BoardVO : " + board);
		service.write(board);
		rttr.addAttribute("msg", "Write Success");
		
		return "redirect:/board/list?div=" + board.getDiv();
	}
	
	@GetMapping({"/get"})
	@Transactional
	public void get(int bno, Model model) {
		
		log.info("Board Get Bno : " + bno);
		
		service.hit(bno);
		model.addAttribute("board", service.get(bno));
		model.addAttribute("reply", reply_service.list(bno));
	}
	
	@GetMapping({"/update"})
	public void update(int bno, Model model) {
		
		log.info("Board Update Bno : " + bno);
		
		model.addAttribute("board", service.get(bno));
	}
	@PostMapping("/update")
	public String update(BoardVO board, RedirectAttributes rttr) {
		
		if(service.update(board)) {
			rttr.addAttribute("msg", "Update Success");
			log.info("Update Board : " + board);
		}
		else {
			rttr.addAttribute("msg", "Update Fail");
			log.info("Can't Update Board : " + board);
		}
		
		return "redirect:/board/list?div=" + board.getDiv();
	}
	
	@GetMapping("/remove")
	public String remove(int bno, RedirectAttributes rttr) {
		
		int div = service.get(bno).getDiv();
		
		if(service.remove(bno))
			log.info("Remove Board Bno : " + bno);
		else
			log.warn("Can't Remove Board Bno : " + bno);
		
		return "redirect:/board/list?div=" + div;
	}
}
