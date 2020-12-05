package org.practice.service;

import java.util.List;

import org.practice.domain.BoardVO;
import org.practice.domain.Pager;
import org.practice.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	
	@Override
	public List<BoardVO> getList(int div, Pager p) {
		
		log.info("=============================");
		log.info("@Service, BOARD SERVICE GET LIST with Pager: " + p);
		switch(div) {
		case 100:
			log.info("# 자유게시판");
			break;
		case 101:
			log.info("# 출석게시판");
			break;
		case 102:
			log.info("# 맛집게시판");
			break;
		}
		log.info("=============================");
		
		return mapper.getListWithPaging(div, p);
	}
	
	
	@Override
	public List<BoardVO> getNotices(int div) {
		
		log.info("==============================");
		log.info("@Board Service, get Notices Div = " + div);
		
		return mapper.getNoticeList(div);
	}
	

	@Override
	public BoardVO get(int bno) {
		
		if(mapper.exist(bno) != null) {
			log.info("===================================");
			log.info("@Servcie, GET BNO : " + bno);
			log.info("===================================");
			return mapper.get(bno);
		}
		else
			return null;
		
	}

	@Override
	public boolean update(BoardVO board) {
		
		log.info("===================================");
		log.info("Update Board : " + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(int bno) {

		if(mapper.exist(bno) != null) {
			log.info("===================================");
			log.info("Remove Board Bno : " + bno);
		}
		else
			log.warn("Can't Remove Board Bno : " + bno);
		return mapper.remove(bno) == 1;
	}

	@Override
	public void write(BoardVO board) {
		
		log.info("Write Board : " + board);
		
		mapper.write(board);
	}
	
	@Override
	public void hit(int bno) {
		
		log.info("Board " + bno + " Hit + 1");
		mapper.hit(bno);
	}

	@Override
	public void hit_minus(int bno) {
		
		log.info("Board " + bno + " Hit - 1");
		mapper.hit_minus(bno);
	}
	@Override
	public int getTotal(int div, Pager p) {
		
		return mapper.getTotal(div, p);
	}
	@Override
	public String getNextBno(int bno, int div) {
		// TODO Auto-generated method stub
		return mapper.next_bno(bno, div);
		
	}
	@Override
	public String getPrevBno(int bno, int div) {
		// TODO Auto-generated method stub
		return mapper.prev_bno(bno, div);
	}
	
}
