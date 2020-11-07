package org.practice.service;

import org.practice.domain.MemberVO;
import org.practice.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public void createAccount(MemberVO member) {
		
		log.info("## ## ## ## ##");
		log.info("MemberVO : " + member);
		
		mapper.createAccount(member);
	}

	
}
