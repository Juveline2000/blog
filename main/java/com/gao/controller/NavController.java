package com.gao.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gao.entity.Content;
import com.gao.entity.LeavingMessage;
import com.gao.entity.Nav;
import com.gao.entity.PageBean;
import com.gao.service.ContentService;
import com.gao.service.LeavingMessageService;
import com.gao.service.NavService;
import com.gao.util.PageUtil;
import com.gao.util.PropertiesUtil;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/nav")
public class NavController {

	@Resource
	NavService navService;
	@Resource
	LeavingMessageService leavingMessageService;
	@Resource
	ContentService contentService;
	
	/**
	 * 点击nav 上面的 标签 根据id显示内容
	 * */
	@RequestMapping("/list")
	public String list(String page,HttpServletRequest request,String id){
		List<Nav>navList = navService.findNav(null);
		request.setAttribute("navList", navList);
		if (page==null) {
			page = "1";
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("pageSize")));
		Map<String, Object>contentMap = new HashMap<String, Object>();
		contentMap.put("start", pageBean.getStart());
		contentMap.put("size", pageBean.getPageSize());
		contentMap.put("id", id);
		List<Content>contentList = contentService.find(contentMap);
		request.setAttribute("contentList", contentList);
		Integer totalNum = contentService.getTotal(contentMap);
		String pageCode = PageUtil.genPagination("nav/list.do?id="+id, totalNum, Integer.parseInt(page), pageBean.getPageSize(),id);
		request.setAttribute("pageCode", pageCode);
		return "index";
	}
	
	/**
	 * 投稿页
	 * */
	@RequestMapping("/contribute")
	public String contribute(HttpServletRequest request){
		request.setAttribute("mainPage", "nav/contribute.jsp");
		return "index";
	}
	
	/**
	 * 赞助页
	 * */
	@RequestMapping("/sponsor")
	public String sponsor(HttpServletRequest request){
		request.getSession().setAttribute("title", "nav/sponsor.do");
		Map<String, Object>map =new HashMap<String, Object>();
		map.put("commentPage", "nav/sponsor.do");
		List<LeavingMessage>leavingMessagesList = leavingMessageService.find(map);
		request.setAttribute("leavingMessagesList", leavingMessagesList);
		request.setAttribute("mainPage", "nav/sponsor.jsp");
		return "index";
	}
	
	/**
	 * 留言页
	 * 
	 * title  表示 所在的哪个页   留言时用到
	 * */
	@RequestMapping("/leavingMessage")
	public String list(HttpServletRequest request){
		request.getSession().setAttribute("title", "nav/leavingMessage.do");
		Map<String, Object>map =new HashMap<String, Object>();
		map.put("commentPage", "nav/leavingMessage.do");
		List<LeavingMessage>leavingMessagesList = leavingMessageService.find(map);
		request.setAttribute("leavingMessagesList", leavingMessagesList);
		request.setAttribute("mainPage", "leavingMessage/leavingMessage.jsp");
		return "index";
	}
	
	

	/**
	 * 后台导航栏
	 * */
	@RequestMapping("/backstageList")
	public String backstageList(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Nav nav,HttpServletResponse response) throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nav", StringUtil.formatLike(nav.getNav()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Nav>navList = navService.findNav(map);
		Long total = navService.getTotal(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(navList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 添加nav导航栏
	 * @throws Exception 
	 * */
	@RequestMapping("/addNav")
	public String addNav(Nav nav,HttpServletRequest request,HttpServletResponse response) throws Exception{
		navService.add(nav);
		JSONObject result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	
}
