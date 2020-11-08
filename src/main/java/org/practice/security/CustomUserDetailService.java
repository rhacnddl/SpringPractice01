package org.practice.security;

import org.practice.domain.MemberVO;
import org.practice.mapper.MemberMapper;
import org.practice.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService{

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		log.warn("Load User By UserName: " + username);
		
		MemberVO member = mapper.read(username);
		
		log.warn("Queried By Member Mapper: " + member);
		
		return member == null? null : new CustomUser(member);
	}

}
