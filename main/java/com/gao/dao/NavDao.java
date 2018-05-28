package com.gao.dao;

import java.util.List;
import java.util.Map;

import com.gao.entity.Nav;

public interface NavDao {

	List<Nav> findNav(Map<String, Object>map);
	
	Nav findById(Integer id);
	
	Long getTotal(Map<String, Object>map);
	
	Integer add(Nav nav);

	void delete(String id);

	Integer update(Nav nav);
}
