package org.practice.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String pw;
	private String username;
	private Date regDate;
	private String email;
	
	private List<AuthVO> authList;
}
