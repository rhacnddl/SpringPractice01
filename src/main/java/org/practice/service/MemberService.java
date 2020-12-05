package org.practice.service;

import java.util.List;

import org.practice.domain.AuthVO;
import org.practice.domain.MemberVO;

public interface MemberService {

	public void createAccount(MemberVO member);
	public void defaultAuth(String userid);
	
	public List<AuthVO> memberList();
	public boolean memberGrant(AuthVO auth);
	
	public MemberVO read(String userid);
	public boolean update(MemberVO member);
}
