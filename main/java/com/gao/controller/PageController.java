package com.gao.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gao.entity.Content;
import com.gao.entity.Nav;
import com.gao.entity.PageBean;
import com.gao.service.ContentService;
import com.gao.service.NavService;
import com.gao.util.PageUtil;
import com.gao.util.PropertiesUtil;
import com.gao.util.StringUtil;
@Controller
@RequestMapping("/")
public class PageController {
	@Resource
	private NavService navService;
	@Resource
	private ContentService contentService;
	
	@RequestMapping("/page")
	public String list(String page,HttpServletRequest request,Content content) throws Exception {
		List<Nav>navList = navService.findNav(null);
		request.setAttribute("navList", navList);
		if (page==null) {
			page = "1";
		}
		StringBuffer param = new StringBuffer();
		
		if (StringUtil.isNotEmpty(content.getComment())) {
			param.append("comment="+content.getComment()+"&");
		}
		if (content.getComment()!=null) {
			content.setComment(content.getComment().replaceAll("Äê", "-"));
			content.setComment(content.getComment().replaceAll("ÔÂ", ""));
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("pageSize")));
		Map<String, Object>contentMap = new HashMap<String, Object>();
		contentMap.put("start", pageBean.getStart());
		contentMap.put("size", pageBean.getPageSize());
		contentMap.put("search", StringUtil.formatLike(content.getTitle()));
		contentMap.put("tag", StringUtil.formatLike(content.getTag()));
		contentMap.put("createDate", content.getComment());
		List<Content>contentList = contentService.find(contentMap);
		if (content.getTitle()!=null) {
			for (@SuppressWarnings("rawtypes")
			Iterator iterator = contentList.iterator(); iterator.hasNext();) {
				Content content2 = (Content) iterator.next();
				content2.setComment(content2.getComment().replaceAll("(?i)"+content.getTitle(), "<span style='color:red;'>"+content.getTitle()+"</span>"));
				content2.setTitle(content2.getTitle().replaceAll("(?i)"+content.getTitle(), "<span style='color:red;'>"+content.getTitle()+"</span>"));
			}
		}
		for (Content content2 : contentList) {
			if (content2.getComment().indexOf("<hr/>")!=-1) {
				content2.setComment(content2.getComment().substring(0, content2.getComment().indexOf("<hr/>")));;
			}
		}
		request.setAttribute("contentList", contentList);
		Integer totalNum = contentService.getTotal(contentMap);
		
		if (StringUtil.isNotEmpty(content.getTag())) {
			param.append("tag="+content.getTag()+"&");
		}
		
		String pageCode = PageUtil.genPagination("page.html", totalNum, Integer.parseInt(page), pageBean.getPageSize(),param.toString());
		request.setAttribute("pageCode", pageCode);
		return "index";
	}
	

	@RequestMapping("/nav")
	public String list(String page,HttpServletRequest request,String id){
		List<Nav>navList = navService.findNav(null);
		request.setAttribute("navList", navList);
		if (page==null) {
			page = "1";
		}
		for (Nav nav : navList) {
			if (nav.getId()==Integer.parseInt(id)) {
				request.setAttribute("sendTitle", nav.getNav());
				break;
			}
		}
		
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("pageSize")));
		Map<String, Object>contentMap = new HashMap<String, Object>();
		contentMap.put("start", pageBean.getStart());
		contentMap.put("size", pageBean.getPageSize());
		contentMap.put("navId", id);
		List<Content>contentList = contentService.find(contentMap);
		for (Content content2 : contentList) {
			if (content2.getComment().indexOf("<hr/>")!=-1) {
				content2.setComment(content2.getComment().substring(0, content2.getComment().indexOf("<hr/>")));;
			}
		}
		request.setAttribute("contentList", contentList);
		Integer totalNum = contentService.getTotal(contentMap);
		
		StringBuffer param = new StringBuffer();
		if (id!=""&&id!=null) {
			param.append("id="+id+"&");
		}
		String pageCode = PageUtil.genPagination("nav.html", totalNum, Integer.parseInt(page), pageBean.getPageSize(),param.toString());
		request.setAttribute("pageCode", pageCode);
		return "index";
	}



}
