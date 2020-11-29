package org.practice.service;

import java.util.List;

import org.practice.domain.BoardVO;
import org.practice.domain.Pager;

public interface BoardService {

	public List<BoardVO> getList(int div, Pager p);
	public List<BoardVO> getNotices(int div);
	public BoardVO get(int bno);
	public boolean update(BoardVO board);
	public boolean remove(int bno);
	public void write(BoardVO board);
	public void hit(int bno);
	public void hit_minus(int bno);
	
	public int getTotal(int div, Pager p);
	public String getNextBno(int bno, int div);
	public String getPrevBno(int bno, int div);
}
