package com.gao.dao;

import java.util.List;
import java.util.Map;

import com.gao.entity.Link;

public interface LinkDao {

	List<Link>find(Map<String, Object>map);
	
	Integer getTotal(Map<String, Object>map);

	void delete(String id);
	
	Integer add(Link link);
	
	Integer update(Link link);
}
