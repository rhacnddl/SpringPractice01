package org.practice.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.practice.domain.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ReplyMapperTest {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	/*
	@Test
	public void writeTest() {
		
		ReplyVO re = new ReplyVO();
		
		re.setBno(1);
		re.setContent("Test Reply");
		re.setWriter("test1");
		
		log.info("===================");
		log.info("Reply Write: " + re);
		
		mapper.write(re);
	}
	
	@Test
	public void write_rTest() {
		
		ReplyVO re = new ReplyVO();
		
		re.setBno(1);
		re.setContent("Test Reply_r 111");
		re.setWriter("test1");
		re.setR_rno(mapper.get(1).getRno());
		
		log.info("===================");
		log.info("Reply Write: " + re);
		
		if(Integer.toString(re.getR_rno()) != null) {
			log.info("Reply Write_r !!!");
			mapper.write_r(re);
		}
		else {
			log.info("Reply Write !!!");
			mapper.write(re);
		}
	}
	
	@Test
	public void removeTest() {
		
		ReplyVO re = mapper.get(2);
		
		log.info("Remove Reply Test ReplyVO : " + re);
		
		mapper.remove(re.getRno());
	}
	*/
	@Test
	public void updateTest() {
		
		ReplyVO re = mapper.get(1);
		
		re.setContent("update Reply");
		
		log.info("Update Test ReplyVO : " + re);
		
		mapper.update(re);
	}
}
