package com.gao.service.impl;








import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.LinkDao;
import com.gao.entity.Link;
import com.gao.service.LinkService;

@Service("linkService")
public class LinkServiceImpl implements LinkService{

	@Resource
	LinkDao linkDao;
	
	public List<Link> find(Map<String, Object> map) {
		return linkDao.find(map);
	}

	public Integer getTotal(Map<String, Object> map) {
		return linkDao.getTotal(map);
	}

	public void delete(String id) {
		linkDao.delete(id);
	}

	public Integer add(Link link) {
		return linkDao.add(link);
	}

	public Integer update(Link link) {
		return linkDao.update(link);
	}

}
