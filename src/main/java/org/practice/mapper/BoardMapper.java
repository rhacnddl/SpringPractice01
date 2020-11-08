package org.practice.mapper;

import java.util.List;

import org.practice.domain.BoardVO;

public interface BoardMapper {

	public List<BoardVO> getList(int div);
	public void write(BoardVO board);
	public void update(BoardVO board);
	public void remove(int bno);
}
