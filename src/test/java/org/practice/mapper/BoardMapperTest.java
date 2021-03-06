package org.practice.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.practice.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardMapperTest {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	
	@Test
	public void writeTest() {
		
		BoardVO board = new BoardVO();
		for(int i=1; i<6; i++) {
		board.setTitle("공지사항 테스트 <" + i + ">^^");
		board.setContent("안녕하세요. Admin입니다.< " + i + ">");
		board.setWriter("test1");
		board.setDiv(101);
		board.setNotice(1);
		
		log.info("BoardVO : " + board);
		
		mapper.write(board);
		}
	}
	/*
	@Test
	public void getListTest() {
		
		List<BoardVO> list = mapper.getList(100);
		
		log.info(list);
	}
	
	@Test
	public void removeTest() {
		int bno = 2;
		BoardVO board = mapper.get(bno);
		if(board != null) {
			log.info("Remove BNO : " + bno);
			mapper.remove(bno);
		}
		else
			log.info("BNO " + bno + " is not exist");
	}
	
	@Test
	public void updateTest() {
		String title = "test4";
		String content = "test4";
		int bno = 1;
		
		BoardVO board = mapper.get(bno);
		if(board != null) {
			board.setTitle(title);
			board.setContent(content);
			
			log.info(board);
			mapper.update(board);
		}
	}
	*/
	@Test
	public void getTest() {
		
		int bno = 29;
		BoardVO vo = mapper.get(bno);
		log.info(vo);
	}
}
