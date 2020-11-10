 package org.practice.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private String content;
	private String writer;
	
	private int rno;
	private int bno;
	private int r_rno;
	
	private Date regDate;
	private Date updateDate;
}
