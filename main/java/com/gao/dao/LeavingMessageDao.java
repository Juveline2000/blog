package com.gao.dao;

import java.util.List;
import java.util.Map;

import com.gao.entity.LeavingMessage;

public interface LeavingMessageDao {

	List<LeavingMessage>find(Map<String, Object>map);
	
	Long getTotal(Map<String, Object>map);

	Integer save(LeavingMessage leavingMessage);

	void delete(String id);
	LeavingMessage findById(Integer id);
	
}
