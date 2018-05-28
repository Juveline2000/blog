package com.gao.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gao.dao.UserDao;
import com.gao.entity.User;
import com.gao.service.UserService;



@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource
	UserDao userDao;
	
	
	 
	public User login(User user) {
		return userDao.login(user);
	}


	 
	public void register(User user) {
		userDao.register(user);
	}


	 
	public User findByName(User user) {
		return userDao.findByName(user);
	}


	 
	public void update(User user) {
		userDao.update(user);
	}


	 
	public List<User> list(Map<String, Object> map) {
		return userDao.list(map);
	}


	 
	public Integer getTotal(Map<String, Object> map) {
		return userDao.getTotal(map);
	}


	 
	public void delete(String id) {
		userDao.delete(id);
	}

}
