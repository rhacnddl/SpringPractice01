package org.practice.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Pager p;
	
	public PageDTO(Pager p, int total) {
		this.p = p;
		this.total = total;
		
		this.endPage = (int) Math.ceil(p.getPage() / 10) * 5;
		this.startPage = endPage - 4;
		
		int realEnd = (int) (Math.ceil(p.getAmount() * 1.0) / p.getAmount());
		
		if(this.endPage > realEnd)
			this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
