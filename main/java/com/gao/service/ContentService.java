package com.gao.service;

import java.util.List;
import java.util.Map;

import com.gao.entity.Content;
import com.gao.entity.LogDate;

public interface ContentService {

	List<Content>find(Map<String, Object>map);
	
	Integer getTotal(Map<String, Object>map);

	void delete(String id);
	
	Integer add(Content content);

	Integer update(Content content);
	
	Content findById(Integer id);
	
	Content findByTitle(Content content);

	List<LogDate> findLogDate();
}
