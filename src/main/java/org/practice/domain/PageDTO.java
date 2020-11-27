package org.practice.domain;

import lombok.Getter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Getter
@ToString
@Log4j
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Pager p;
	
	public PageDTO(Pager p, int total) {
		this.p = p;
		this.total = total;
		
		this.endPage = (int) Math.ceil(p.getPage() / 5.0) * 5;
		this.startPage = endPage - 4;
		
		int realEnd = (int) (Math.ceil(total * 1.0) / p.getAmount());
		
		if(realEnd < this.endPage)
			this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		log.info(this.toString());
	}
	
}
