package org.practice.mapper;

import java.util.List;

import org.practice.domain.ReplyVO;

public interface ReplyMapper {

	public void write(ReplyVO reply);
	public void write_r(ReplyVO reply);
	public int remove(int rno);
	public int update(ReplyVO reply);
	public ReplyVO get(int rno);
	
	public List<ReplyVO> list(int bno);
}
