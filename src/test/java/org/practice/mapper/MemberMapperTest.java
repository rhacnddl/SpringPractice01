package org.practice.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.practice.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberMapperTest {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	/*
	@Test
	public void createTest() {
		
		MemberVO vo = new MemberVO();
		
		vo.setUserid("test2");
		vo.setPw("test2");
		vo.setUsername("test2");
		vo.setEmail("test2@naver.com");
		
		mapper.createAccount(vo);
	}
	*/
	@Test
	public void readTest() {
		MemberVO vo = mapper.read("admin");
		
		log.info(vo);
		
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
}
