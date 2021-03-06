package org.practice.service;

import java.util.List;

import org.practice.domain.ReplyVO;
import org.practice.mapper.BoardMapper;
import org.practice.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper board_mapper;
	
	
	@Override
	public void write(ReplyVO reply) {
		// TODO Auto-generated method stub
		log.info("======================");
		log.info("@Service, Reply Write : " + reply);
		log.info("======================");
		
		mapper.write(reply);
		board_mapper.updateCnt(reply.getBno(), 1);
	}

	@Override
	public void write_r(ReplyVO reply) {
		// TODO Auto-generated method stub
		log.info("======================");
		log.info("@Service, Reply Write_r : " + reply);
		log.info("======================");
		
		mapper.write_r(reply);
		board_mapper.updateCnt(reply.getBno(), 1);
	}

	@Override
	public boolean update(ReplyVO reply) {
		// TODO Auto-generated method stub
		log.info("======================");
		log.info("@Service, Reply Update : " + reply);
		log.info("======================");
		
		return mapper.update(reply) == 1;
	}

	@Override
	public boolean remove(int rno) {
		// TODO Auto-generated method stub
		log.info("======================");
		log.info("@Service, Reply Remove RNO : " + rno);
		log.info("======================");
		
		ReplyVO reply = mapper.get(rno);
		
		board_mapper.updateCnt(reply.getBno(), -1);
		
		return mapper.remove(rno) == 1;
	}

	@Override
	public ReplyVO get(int rno) {
		// TODO Auto-generated method stub
		log.info("======================");
		log.info("@Service, Reply Get RNO: " + rno);
		log.info("======================");
		
		return mapper.get(rno);
	}

	@Override
	public List<ReplyVO> list(int bno) {
		// TODO Auto-generated method stub
		log.info("======================");
		log.info("@Service, Reply List From BNO : " + bno);
		log.info("======================");
		
		return mapper.list(bno);
	}
	
}
