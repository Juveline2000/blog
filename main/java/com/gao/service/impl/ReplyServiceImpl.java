package com.gao.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.ReplyDao;
import com.gao.entity.Reply;
import com.gao.service.ReplyService;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService {

	@Resource
	ReplyDao replyDao;
	 
	public Integer save(Reply reply) {
		return replyDao.save(reply);
	}

	public List<Reply> findById(Integer id) {
		return replyDao.findById(id);
	}

	public Long getTotal(Map<String, Object> map) {
		return replyDao.getTotal(map);
	}

	public List<Reply> find(Map<String, Object> map) {
		return replyDao.find(map);
	}

	public void delete(String id) {
		replyDao.delete(id);
	}

}
