package com.gao.service;

import java.util.List;
import java.util.Map;

import com.gao.entity.User;

public interface UserService {

	List<User> list(Map<String, Object>map);
	Integer getTotal(Map<String, Object>map);
	void delete(String id);
	
	User login(User user);

	User findByName(User user);
	void register(User user);
	void update(User user);
}
