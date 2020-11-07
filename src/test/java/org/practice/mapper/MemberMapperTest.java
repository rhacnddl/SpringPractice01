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
	
	@Test
	public void createTest() {
		
		String userid = "test1";
		String username = "test1";
		String pw = "12345";
		String email = "test1@naver.com";
		
		MemberVO vo = new MemberVO(userid, username, pw, email);
		
		mapper.createAccount(vo);
	}
}
