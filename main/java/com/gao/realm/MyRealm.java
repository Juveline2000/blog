package com.gao.realm;


import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.gao.entity.User;
import com.gao.service.BloggerService;

public class MyRealm extends AuthorizingRealm{
	
	@Resource
	BloggerService bloggerService;
	
	/**
	 * ��ȡ��ǰ�ĵ�¼�û�
	 * */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		String userName = (String)token.getPrincipal();//��ȡ�����Ϣ(�û���,��¼����)
		try {
			User user = bloggerService.getByUserName(userName);
			if (user!=null) {
				//�ѵ�ǰ��Ϣ����session ����û���һ������ȷ��¼���û�,�˷ѵ��ڴ�,д��controller�ﻹҪ������,�鷳Щ
				SecurityUtils.getSubject().getSession().setAttribute("currentUser", user);
				//�û�������������ݿ�ȡ ,xx:realmName,���д
				AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(user.getUserName(),user.getPassword(),"xx");
				return authcInfo;
			}else{
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * Ϊ��ǰ��¼���û������ɫ��Ȩ��
	 * */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		return null;
	}

	

}
