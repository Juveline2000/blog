package com.gao.service.impl;

import com.gao.service.LeavingMessageService;







import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.LeavingMessageDao;
import com.gao.entity.LeavingMessage;
@Service("leavingMessageService")
public class LeavingMessageServiceImpl implements LeavingMessageService{

	@Resource
	LeavingMessageDao leavingMessageDao;

	 
	public List<LeavingMessage> find(Map<String, Object> map) {
		return leavingMessageDao.find(map);
	}

	 
	public Long getTotal(Map<String, Object> map) {
		return leavingMessageDao.getTotal(map);
	}

	 
	public Integer save(LeavingMessage leavingMessage) {
		return leavingMessageDao.save(leavingMessage);
	}


	public void delete(String id) {
		leavingMessageDao.delete(id);
	}


	public LeavingMessage findById(Integer id) {
		return leavingMessageDao.findById(id);
	}
	
}
