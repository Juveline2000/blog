package com.gao.service;

import java.util.List;
import java.util.Map;

import com.gao.entity.User;

public interface BloggerService {

	/**
	 * 登录
	 * */
	public User getByUserName(String userName);
	
	/**
	 * 查询所有用户
	 * */
	public List<User> find(Map<String, Object> map);
	

	/**
	 * 获取总页数
	 * */
	public Long getTotal(Map<String, Object> map);

	/**
	 * 修改用户
	 * */
	public int update(User blogger);
	
	/**
	 * 添加用户
	 * */
	public int add(User blogger);
	
	/**
	 * 删除用户
	 * */
	public int delete(Integer id);
}
