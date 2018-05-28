package com.gao.service.impl;

import java.util.List;
import java.util.Map;






import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.BloggerDao;
import com.gao.entity.User;
import com.gao.service.BloggerService;

@Service("bloggerService")
public class BloggerServiceImpl implements BloggerService{
	@Resource
	BloggerDao bloggerDao;
	
	public User getByUserName(String userName) {
		return bloggerDao.getByUserName(userName);
	}

	public List<User> find(Map<String, Object> map) {
		// TODO 自动生成的方法存根
		return bloggerDao.find(map);
	}

	public Long getTotal(Map<String, Object> map) {
		// TODO 自动生成的方法存根
		return bloggerDao.getTotal(map);
	}

	public int update(User blogger) {
		// TODO 自动生成的方法存根
		return bloggerDao.update(blogger);
	}

	public int add(User blogger) {
		// TODO 自动生成的方法存根
		return bloggerDao.add(blogger);
	}

	public int delete(Integer id) {
		// TODO 自动生成的方法存根
		return bloggerDao.delete(id);
	}
	


}
