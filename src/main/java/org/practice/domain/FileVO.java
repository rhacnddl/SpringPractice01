package org.practice.domain;

import lombok.Data;

@Data
public class FileVO {
	
	private String path;
	private String fileName;
	private char fileType;
	private int bno;
}
