package org.practice.service;

import java.util.List;

import org.practice.domain.BoardVO;

public interface BoardService {

	public List<BoardVO> getList(int div);
	public BoardVO get(int bno);
	public boolean update(BoardVO board);
	public boolean remove(int bno);
	public void write(BoardVO board);
	public void hit(int bno);
	
	public void hit_minus(int bno);
}
