package com.gao.controller;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.gao.entity.Content;
import com.gao.entity.Nav;
import com.gao.entity.User;
import com.gao.service.ContentService;
import com.gao.service.LinkService;
import com.gao.service.NavService;
import com.gao.util.DateUtil;
import com.gao.util.PageUtil;
import com.gao.util.PropertiesUtil;
import com.gao.entity.*;

@Component
public class InitController implements ServletContextListener,ApplicationContextAware{

	//application对象:服务器开着就一直在 
		//静态
		private static ApplicationContext applicationContext;
		public void contextDestroyed(ServletContextEvent arg0) {
			
		}
		public void contextInitialized(ServletContextEvent servletContextEvent) {
				ServletContext application = servletContextEvent.getServletContext();
				NavService navService = (NavService) applicationContext.getBean("navService");
				List<Nav>navList = navService.findNav(null);
				application.setAttribute("navList", navList);
				
				PageBean pageBean = new PageBean(1, Integer.parseInt(PropertiesUtil.getValue("pageSize")));
				ContentService contentService = (ContentService) applicationContext.getBean("contentService");
				Map<String, Object>contentMap = new HashMap<String, Object>();
				contentMap.put("start", pageBean.getStart());
				contentMap.put("size", pageBean.getPageSize());
				List<Content>contentList = contentService.find(contentMap);
				application.setAttribute("contentList", contentList);
				Integer totalNum = contentService.getTotal(contentMap);
//				String pageCode = PageUtil.getPagation("refurbish/list.do", totalNum, pageBean.getPage(), pageBean.getPageSize(),null);
				String pageCode = PageUtil.genPagination("page.html", totalNum, pageBean.getPage(), pageBean.getPageSize(),null);
				application.setAttribute("pageCode", pageCode);
				User user = new User();
				user.setNickName("SaikiKuSuo");
				user.setDetails("2018年过了快一半了  还是没有钱");
				user.setHeadPortrait("qi.png");
				application.setAttribute("currentUser", user);
				
				//日志日期
				List<LogDate> logDateList = contentService.findLogDate();
				application.setAttribute("logDateList", logDateList);
				
				//友情链接
				LinkService linkService = (LinkService)applicationContext.getBean("linkService");
				List<Link>linkList = linkService.find(null);
				application.setAttribute("linkList", linkList);
			}


		public void setApplicationContext(ApplicationContext applicationContext)
				throws BeansException {
			this.applicationContext = applicationContext;
		}

	
}
