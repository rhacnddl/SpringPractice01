package org.practice.mapper;

import java.util.List;

import org.practice.domain.FileVO;

public interface UploadMapper {

	public void upload(List<FileVO> list);
	public List<FileVO> getFileList(int bno);
	public FileVO getFile(String uuid);
	public int deleteFile(String uuid);
}
