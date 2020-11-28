package org.practice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.practice.domain.BoardVO;
import org.practice.domain.FileVO;
import org.practice.domain.Pager;

public interface BoardMapper {

	public List<BoardVO> getListWithPaging(@Param("div") int div, @Param("p") Pager p); 
	//public List<BoardVO> getList(int div); //해당 Div의 게시글 목록
	
	public void write(BoardVO board); //게시물 작성
	public int update(BoardVO board); //게시물 수정
	public int remove(int bno);       //게시물 삭제
	
	public BoardVO get(int bno);      //게시물 상세
	public FileVO getFile(int bno);   //게시물의 첨부파일
	
	public void hit(int bno);         //조회수 +1
	public void hit_minus(int bno);   //조회수 -1 //댓글 작성 후 조회수 증가하는 현상을 제거하기 위해 hit = hit - 1
	public String exist(int bno);     //게시물 존재?
	
	public void updateCnt(@Param("bno")int bno, @Param("amount")int amount); //게시물의 댓글 수 처리
	
	public int getTotal(@Param("div")int div, @Param("p")Pager p);
	public String next_bno(@Param("bno")int bno, @Param("div") int div); //게시글의 다음 글 번호
	public String prev_bno(@Param("bno")int bno, @Param("div") int div); //게시글의 이전 글 번호
}
