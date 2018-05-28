package com.gao.dao;

import java.util.List;
import java.util.Map;

import com.gao.entity.User;

public interface BloggerDao {

	/**
	 * ��¼
	 * */
	public User getByUserName(String userName);
	
	/**
	 * ��ѯ�����û�
	 * */
	public List<User> find(Map<String, Object> map);
	

	/**
	 * ��ȡ��ҳ��
	 * */
	public Long getTotal(Map<String, Object> map);

	/**
	 * �޸��û�
	 * */
	public int update(User blogger);
	
	/**
	 * ����û�
	 * */
	public int add(User blogger);
	
	/**
	 * ɾ���û�
	 * */
	public int delete(Integer id);
}
