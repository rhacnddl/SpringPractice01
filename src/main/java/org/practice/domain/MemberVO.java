package org.practice.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	
	public MemberVO(String userid, String username, String pw, String email) {
		this.userid = userid;
		this.username = username;
		this.pw = pw;
		this.email = email;
	}
	private String userid;
	private String pw;
	private String username;
	private Date regDate;
	private String email;
}
