package com.gao.service;

import java.util.List;
import java.util.Map;

import com.gao.entity.Reply;


public interface ReplyService {

	List<Reply> findById(Integer id);

	List<Reply> find(Map<String, Object>map);
	Integer save(Reply reply);
	Long getTotal(Map<String, Object>map);

	void delete(String id);
}
