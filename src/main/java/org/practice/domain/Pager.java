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
	private int amount;
	
	private String type;
	private String key;
	
	
	public Pager() {
		this(1,10);
	}
	
	public Pager(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
	
	public String[] getTypes() {
		return type == null? new String[] {}:type.split("");
	}
}
