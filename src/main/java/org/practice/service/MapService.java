package org.practice.service;

import org.practice.domain.MapVO;

public interface MapService {

	public void insert(MapVO map);
	public boolean remove(int bno);
	public MapVO show(int bno);
}
