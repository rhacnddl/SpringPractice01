package org.practice.service;

import org.practice.domain.MemberVO;
import org.practice.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	@Override
	public void createAccount(MemberVO member) {
		
		member.setPw(encoder.encode(member.getPw()));
		log.info("MemberVO : " + member);
		
		mapper.createAccount(member);
	}

	@Override
	public void defaultAuth(String userid) {
		
		log.info("Add Default Auth 'Member'");
		log.info("Userid : " + userid);
		
		mapper.defaultAuth(userid);
	}

	
	
}
