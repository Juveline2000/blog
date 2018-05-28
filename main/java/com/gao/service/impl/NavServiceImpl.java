package com.gao.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.NavDao;
import com.gao.entity.Nav;
import com.gao.service.NavService;

@Service("navService")
public class NavServiceImpl implements NavService {

	@Resource
	NavDao navDao;
	

	 
	public Long getTotal(Map<String, Object> map) {
		return navDao.getTotal(map);
	}


	 
	public List<Nav> findNav(Map<String, Object> map) {
		return navDao.findNav(map);
	}



	public Integer add(Nav nav) {
		return navDao.add(nav);
	}



	public void delete(String id) {
		navDao.delete(id);
	}



	public Integer update(Nav nav) {
		return navDao.update(nav);
	}

}
