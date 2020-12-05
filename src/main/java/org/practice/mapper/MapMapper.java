package org.practice.mapper;

import org.practice.domain.MapVO;

public interface MapMapper {

	public MapVO show(int bno);
	public void insert(MapVO map);
	public int remove(int bno);
}
