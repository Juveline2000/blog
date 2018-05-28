package com.gao.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gao.entity.User;
import com.gao.service.BloggerService;
import com.gao.util.CryptographyUtil;


@Controller
@RequestMapping("/blogger")
public class BloggerController {

	
	@Resource
	BloggerService bloggerService;
	
	
	@RequestMapping("/login")
	public String login(User blogger,HttpServletRequest request){
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(blogger.getUserName(),CryptographyUtil.md5(blogger.getPassword(), "gao"));
		try {
			subject.login(token);
			Session session = subject.getSession();
			session.setAttribute("password", blogger.getPassword());
			return "redirect:/admin/main.jsp";	
		} catch (Exception e) {
			request.setAttribute("blogger", blogger);
			request.setAttribute("errorInfo", "用户名,密码或用户类型错误");
			return "login";
		}
	}
	
}
