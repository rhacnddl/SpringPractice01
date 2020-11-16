package org.practice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.practice.domain.FileVO;

public interface UploadMapper {

	public void upload(List<FileVO> list);
	public void update(@Param("list") List<FileVO> list, @Param("bno") int bno);
	public List<FileVO> getFileList(int bno);
	public FileVO getFile(String uuid);
	public int deleteFile(String uuid);
}
