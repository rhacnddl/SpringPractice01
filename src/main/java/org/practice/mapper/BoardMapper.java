package org.practice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.practice.domain.BoardVO;
import org.practice.domain.FileVO;
import org.practice.domain.Pager;

public interface BoardMapper {

	public List<BoardVO> getListWithPaging(@Param("div") int div, @Param("p") Pager p); 
	//public List<BoardVO> getList(int div); //�ش� Div�� �Խñ� ���
	
	public void write(BoardVO board); //�Խù� �ۼ�
	public int update(BoardVO board); //�Խù� ����
	public int remove(int bno);       //�Խù� ����
	
	public BoardVO get(int bno);      //�Խù� ��
	public FileVO getFile(int bno);   //�Խù��� ÷������
	
	public void hit(int bno);         //��ȸ�� +1
	public void hit_minus(int bno);   //��ȸ�� -1 //��� �ۼ� �� ��ȸ�� �����ϴ� ������ �����ϱ� ���� hit = hit - 1
	public String exist(int bno);     //�Խù� ����?
	
	public void updateCnt(@Param("bno")int bno, @Param("amount")int amount); //�Խù��� ��� �� ó��
	
	public int getTotal(@Param("div")int div, @Param("p")Pager p);
	public String next_bno(@Param("bno")int bno, @Param("div") int div); //�Խñ��� ���� �� ��ȣ
	public String prev_bno(@Param("bno")int bno, @Param("div") int div); //�Խñ��� ���� �� ��ȣ
}
