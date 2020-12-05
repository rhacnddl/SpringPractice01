package org.practice.domain;

import lombok.Data;

@Data
public class MailVO {

	private String subject;
	private String text;
	private String from;
	private String to;
}
