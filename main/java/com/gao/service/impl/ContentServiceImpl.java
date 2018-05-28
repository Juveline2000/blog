package com.gao.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.ContentDao;
import com.gao.entity.Content;
import com.gao.entity.LogDate;
import com.gao.service.ContentService;
@Service("contentService")
public class ContentServiceImpl implements ContentService {

	@Resource
	ContentDao contentDao;

	public List<Content> find(Map<String, Object> map) {
		return contentDao.find(map);
	}

	public Integer getTotal(Map<String, Object> map) {
		return contentDao.getTotal(map);
	}

	public Integer add(Content content) {
		return contentDao.add(content);
	}

	public Content findById(Integer id) {
		return contentDao.findById(id);
	}

	public void delete(String id) {
		contentDao.delete(id);
	}

	public List<LogDate> findLogDate() {
		return contentDao.findLogDate();
	}

	public Content findByTitle(Content content) {
		return contentDao.findByTitle(content);
	}

	public Integer update(Content content) {
		return this.contentDao.update(content);
	}
	


}
