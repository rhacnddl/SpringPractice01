package org.practice.mapper;

import java.util.List;

import org.practice.domain.BoardVO;

public interface BoardMapper {

	public List<BoardVO> getList(int div);
	public void write(BoardVO board);
	public int update(BoardVO board);
	public int remove(int bno);
	public BoardVO get(int bno);
	public void hit(int bno);
	public String exist(int bno);
}
