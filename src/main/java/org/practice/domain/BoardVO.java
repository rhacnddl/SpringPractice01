package org.practice.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private int bno;
	private int replyCnt;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
}
