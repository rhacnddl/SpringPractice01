package org.practice.service;

import java.util.List;

import org.practice.domain.ReplyVO;

public interface ReplyService {

	public void write(ReplyVO reply);
	public void write_r(ReplyVO reply);
	public boolean update(ReplyVO reply);
	public boolean remove(int rno);
	public ReplyVO get(int rno);
	public List<ReplyVO> list(int bno);
}
