package org.practice.controller;

import javax.mail.internet.MimeMessage;

import org.practice.domain.MailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mail")
public class MailController {

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	
	@GetMapping("/send")
	public void send() {
		log.info("===============================");
		log.info("@Mail Controller, <GET> send");
	}
	
	@PostMapping("/send")
	public ModelAndView send(MailVO vo, ModelAndView mv) {

		mv.setViewName("/home");
		log.info("@MailController, sendPost MailVO : " + vo);
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			
			@Override 
			public void prepare(MimeMessage mimeMessage) throws Exception {
				
				final MimeMessageHelper helper = 
						new MimeMessageHelper(mimeMessage, true, "UTF-8"); 
					helper.setFrom(vo.getFrom()); 
					helper.setTo(vo.getTo()); 
					helper.setSubject(vo.getSubject()); 
					helper.setText(vo.getText(), true); 
				} 
			}; 
			mailSender.send(preparator);
			
			return mv;
			//return new ResponseEntity<String>("Success", HttpStatus.OK);
	}

}
