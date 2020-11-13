package org.practice.mapper;

import java.util.List;

import org.practice.domain.AuthVO;
import org.practice.domain.MemberVO;

public interface MemberMapper {
	
	public void createAccount(MemberVO vo);
	public void defaultAuth(String userid);
	
	public MemberVO read(String userid);
	
	public List<AuthVO> memberList();
	public int memberGrant(List<AuthVO> list);
	public int updateMember(MemberVO member);
}
