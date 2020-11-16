package org.practice.service;

import java.util.List;

import org.practice.domain.FileVO;
import org.practice.mapper.UploadMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UploadServiceImpl implements UploadService{

	@Setter(onMethod_ = @Autowired)
	private UploadMapper mapper;
	
	@Override
	public void fileUpload(List<FileVO> list) {
		
		log.info("===================================");
		log.info("@Service, UploadService File Upload : " + list);
		log.info("===================================");
		
		mapper.upload(list);
	}
	@Override
	public void fileUpdate(List<FileVO> list, int bno) {
		// TODO Auto-generated method stub
		log.info("===================================");
		log.info("@Service, UploadService File Update : " + list + " BNO : " + bno);
		log.info("===================================");
		
		mapper.update(list, bno);
	}
	
	@Override
	public List<FileVO> getFileList(int bno) {
		
		log.info("===================================");
		log.info("@Service, UploadService Get File List By BNO : " + bno);
		log.info("===================================");
		
		return mapper.getFileList(bno);
	}
	
	@Override
	public FileVO getFile(String uuid) {
		
		log.info("===================================");
		log.info("@Service, UploadService Get File By UUID : " + uuid);
		log.info("===================================");		
		
		return mapper.getFile(uuid);
	}
	
	@Override
	public boolean deleteFile(String uuid) {
		
		log.info("===================================");
		log.info("@Service, UploadService Delete File By UUID : " + uuid);
		log.info("===================================");
		
		return mapper.deleteFile(uuid) == 1;
	}
}
