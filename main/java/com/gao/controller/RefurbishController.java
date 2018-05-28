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
@RequestMapping("/refurbish")
public class RefurbishController {
	@Resource
	private NavService navService;
	@Resource
	private ContentService contentService;
	
	@RequestMapping("/list")
	public String list(String page,HttpServletRequest request,Content content) throws Exception {
		/*if (search!=null) {
			search = StringUtil.unescape(search);
			search=new String(search.getBytes("ISO-8859-1"),"utf-8");
		}
		if (tag!=null) {
			tag=new String(tag.getBytes("ISO-8859-1"),"utf-8");
			tag = StringUtil.unescape(tag);
		}*/
		List<Nav>navList = navService.findNav(null);
		request.setAttribute("navList", navList);
		if (page==null) {
			page = "1";
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
		request.setAttribute("contentList", contentList);
		Integer totalNum = contentService.getTotal(contentMap);
		String pageCode = PageUtil.genPagination("refurbish/list.do", totalNum, Integer.parseInt(page), pageBean.getPageSize(),null);
		request.setAttribute("pageCode", pageCode);
		return "index";
	}
	




}
