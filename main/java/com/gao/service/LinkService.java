package com.gao.service;

import java.util.List;
import java.util.Map;

import com.gao.entity.Link;

public interface LinkService {

	List<Link>find(Map<String, Object>map);
	
	Integer getTotal(Map<String, Object>map);

	void delete(String id);
	
	Integer add(Link link);
	
	Integer update(Link link);
}
