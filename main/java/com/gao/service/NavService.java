package com.gao.service;

import java.util.List;
import java.util.Map;

import com.gao.entity.Nav;

public interface NavService {


	List<Nav> findNav(Map<String, Object>map);
	
	Long getTotal(Map<String, Object>map);
	
	Integer add(Nav nav);
	void delete(String id);

	Integer update(Nav nav);
}
