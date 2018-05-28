package com.gao.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.gao.entity.Content;
import com.gao.entity.Link;
import com.gao.entity.LogDate;
import com.gao.entity.Nav;
import com.gao.entity.PageBean;
import com.gao.entity.User;
import com.gao.service.ContentService;
import com.gao.service.LinkService;
import com.gao.service.NavService;
import com.gao.util.DateUtil;
import com.gao.util.PageUtil;
import com.gao.util.PropertiesUtil;

@Controller
@RequestMapping("/admin/refurbish")
public class RefurbishAdminController {

	
	@Resource
	NavService navService;
	
	@Resource
	ContentService contentService;
	
	@Resource
	LinkService linkService;
	
	@RequestMapping("/refurbishSys")
	public String refurbishSys(HttpServletResponse response,HttpServletRequest request)throws Exception{
		ServletContext application = RequestContextUtils.getWebApplicationContext(request).getServletContext();
		List<Nav>navList = navService.findNav(null);
		application.setAttribute("navList", navList);
		
		
		PageBean pageBean = new PageBean(1, Integer.parseInt(PropertiesUtil.getValue("pageSize")));
		Map<String, Object>contentMap = new HashMap<String, Object>();
		contentMap.put("start", pageBean.getStart());
		contentMap.put("size", pageBean.getPageSize());
		List<Content>contentList = contentService.find(contentMap);
		application.setAttribute("contentList", contentList);
		Integer totalNum = contentService.getTotal(contentMap);
		String pageCode = PageUtil.genPagination("page.html", totalNum, pageBean.getPage(), pageBean.getPageSize(),null);
		application.setAttribute("pageCode", pageCode);
		User user = new User();
		user.setNickName("SaikiKuSuo");
		user.setDetails("今天是："+DateUtil.formatDate(new Date(), "yyyy-MM-dd"));
		user.setHeadPortrait("1.jpg");
		application.setAttribute("currentUser", user);
		
		
		//日志日期
		List<LogDate> logDateList = contentService.findLogDate();
		application.setAttribute("logDateList", logDateList);
		
		//友情链接
		List<Link>linkList = linkService.find(null);
		application.setAttribute("linkList", linkList);
		
		return "admin/main";
	}
}
