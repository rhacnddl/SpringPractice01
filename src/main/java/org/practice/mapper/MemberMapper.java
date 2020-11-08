package org.practice.mapper;

import org.practice.domain.MemberVO;

public interface MemberMapper {
	
	public void createAccount(MemberVO vo);
	public void defaultAuth(String userid);
	
	public MemberVO read(String userid);
}
