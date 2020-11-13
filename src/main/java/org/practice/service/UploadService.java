package org.practice.service;

import java.util.List;

import org.practice.domain.FileVO;
import org.springframework.web.multipart.MultipartFile;

public interface UploadService {

	public void fileUpload(List<FileVO> list);
	public List<FileVO> getFileList(int bno);
}
