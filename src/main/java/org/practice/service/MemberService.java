package org.practice.service;

import org.practice.domain.MemberVO;

public interface MemberService {

	public void createAccount(MemberVO member);
	public void defaultAuth(String userid);
}
