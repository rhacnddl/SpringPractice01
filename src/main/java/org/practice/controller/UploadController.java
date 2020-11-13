package org.practice.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.practice.domain.FileVO;
import org.practice.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class UploadController {

	@Setter(onMethod_ = @Autowired)
	private UploadService service;
	
	public void fileUpload(MultipartFile[] uploadFile) {
					
		String path = "C:\\upload";
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(path, uploadFolderPath);
		
		List<FileVO> list = new ArrayList<FileVO>(); 
		
		log.info("==========================");
		log.info("@Controller, UploadController");
		log.info("Upload Path : " + uploadPath.toString());
		
		//폴더가 없다면 폴더 생성
		if(!uploadPath.exists())
			uploadPath.mkdirs();

		for(MultipartFile file : uploadFile) {
			log.info("File Name : " + file.getOriginalFilename());
			log.info("File Size : " + file.getSize());
			
			//MultipartFile -> File (파일 저장 구현)
			FileVO vo = new FileVO();
			
			UUID uuid = UUID.randomUUID(); //중복방지를 위한 UUID
			String fileName = file.getOriginalFilename();
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1); //IE에서 업로드 할 때를 위함
			
			vo.setFileName(fileName);
			vo.setUuid(uuid.toString());
			vo.setPath(uploadFolderPath);
			//vo.setBno(bno);
			
			fileName = uuid + "_" + fileName;
			
			File saveFile = new File(uploadPath, fileName);
			
			try {
				file.transferTo(saveFile);
				
				if(checkImageType(saveFile)) vo.setFileType('i');
				else vo.setFileType('f');
				
				list.add(vo);
					
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} //for(MultipartFile file : uploadFile)
		
		service.fileUpload(list);
	}
	
	public String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	public boolean checkImageType(File file) {
		
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
