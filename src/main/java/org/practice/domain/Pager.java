package org.practice.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Pager {

	private int page;
	
	private String type;
	private String key;
	
	public Pager() {
		this.page = 1;
	}
	public Pager(String type, String key) {
		this.page = 1;
		this.type = type;
		this.key = key;
	}
	public Pager(int page, String type, String key) {
		this.page = page;
		this.key = key;
		this.type = type;
	}
}
