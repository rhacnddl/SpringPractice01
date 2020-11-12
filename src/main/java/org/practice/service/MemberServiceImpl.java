package org.practice.service;

import java.util.ArrayList;
import java.util.List;

import org.practice.domain.AuthVO;
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
		
		String enc_pw = encoder.encode(member.getPw());
		member.setPw(enc_pw);
		log.info("@Service MemberVO : " + member);
		
		mapper.createAccount(member);
	}

	@Override
	public void defaultAuth(String userid) {
		
		log.info("Add Default Auth 'Member'");
		log.info("@Service Userid : " + userid);
		
		mapper.defaultAuth(userid);
	}

	@Override
	public List<AuthVO> memberList(){
		
		log.info("===========================");
		log.info("@Service, Get Member List");
		
		return mapper.memberList();
	}
	
	@Override
	public boolean memberGrant(AuthVO auth) {

		String[] id_list = auth.getUserid().split(",");
		String[] auth_list = auth.getAuthority().split(",");
		
		List<AuthVO> list = new ArrayList<AuthVO>();
		for(int i=0; i<id_list.length; i++) {
			AuthVO vo = new AuthVO();
			vo.setAuthority(auth_list[i]);
			vo.setUserid(id_list[i]);
			
			list.add(vo);
		}
		
		log.info("==============================");
		log.info("@Service, MemberGrant List : " + list);
		log.info("==============================");
		
		return mapper.memberGrant(list) == 1;
	}
}
