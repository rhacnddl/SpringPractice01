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
		
		board.setTitle("BOARD TEST2");
		board.setContent("BOARD TEST2");
		board.setWriter("test1");
		board.setDiv(100);
		
		log.info("BoardVO : " + board);
		
		mapper.write(board);
	}
	
	@Test
	public void getListTest() {
		
		List<BoardVO> list = mapper.getList(100);
		
		log.info(list);
	}
}
