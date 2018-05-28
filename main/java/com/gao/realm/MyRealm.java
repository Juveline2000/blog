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
	 * 获取当前的登录用户
	 * */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		String userName = (String)token.getPrincipal();//获取身份信息(用户名,登录界面)
		try {
			User user = bloggerService.getByUserName(userName);
			if (user!=null) {
				//把当前信息存入session 这个用户不一定是正确登录的用户,浪费电内存,写在controller里还要调用它,麻烦些
				SecurityUtils.getSubject().getSession().setAttribute("currentUser", user);
				//用户名和密码从数据库取 ,xx:realmName,随便写
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
	 * 为当前登录的用户授予角色和权限
	 * */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		return null;
	}

	

}
