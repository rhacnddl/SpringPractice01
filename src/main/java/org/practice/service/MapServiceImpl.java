package org.practice.service;

import org.practice.domain.MapVO;
import org.practice.mapper.MapMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MapServiceImpl implements MapService{

	@Setter(onMethod_ = @Autowired)
	private MapMapper mapper;
	
	@Override
	public void insert(MapVO map) {
		// TODO Auto-generated method stub
		log.info("=============================");
		log.info("@Service, Map Service.insert MapVO : " + map);
		log.info("=============================");
		
		mapper.insert(map);
	}

	@Override
	public boolean remove(int bno) {
		// TODO Auto-generated method stub
		log.info("=============================");
		log.info("@Service, Map Service.remove BNO : " + bno);
		log.info("=============================");
		
		return (mapper.remove(bno) == 1);
	}

	@Override
	public MapVO show(int bno) {
		// TODO Auto-generated method stub
		log.info("=============================");
		log.info("@Service, Map Service.show BNO : " + bno);
		log.info("=============================");
		
		return mapper.show(bno);
	}

	
}
