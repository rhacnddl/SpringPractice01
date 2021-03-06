package org.practice.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private int bno;
	private int div;
	private int hit;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private int notice;
	
	private List<FileVO> fileList;
	private int cnt;
}
