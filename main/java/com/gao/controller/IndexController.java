package com.gao.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gao.entity.Content;
import com.gao.entity.PageBean;
import com.gao.entity.User;
import com.gao.service.ContentService;
import com.gao.util.PageUtil;
import com.gao.util.PropertiesUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/")
public class IndexController {

	
	@Resource
	ContentService contentService;
	
	/**
	 * 请求主页
	 * */
	@RequestMapping("/index")
	public ModelAndView index(@RequestParam(value="page",required=false)String page,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		if (StringUtil.isEmpty(page)) {
			page="1";
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("pageSize")));
		Map<String, Object>contentMap = new HashMap<String, Object>();
		contentMap.put("start", pageBean.getStart());
		contentMap.put("size", pageBean.getPageSize());
		List<Content>contentList = contentService.find(contentMap);
		/*for (Content content : contentList) {
			List<String>imageList = content.getImageList();
			String contentInfo=content.getComment();
			Document doc = Jsoup.parse(contentInfo);
			//Elements jpgs = doc.select("img[src$=.jpg]");
			Elements jpgs = doc.select("img[src~=(?i)\\.(png|jpe?g)]");
			for(int i = 0; i <jpgs.size();i++){
				Element jpg = jpgs.get(i);
				imageList.add(jpg.toString());
				if (i==2) {
					break;
				}
			}
		}*/
		for (Content content : contentList) {
			if (content.getComment().indexOf("<hr/>")!=-1) {
				content.setComment(content.getComment().substring(0, content.getComment().indexOf("<hr")));;
			}
		}
		mav.addObject("contentList",contentList);
		
		Integer totalNum = contentService.getTotal(contentMap);
//		String pageCode = PageUtil.getPagation("refurbish/list.do", totalNum, pageBean.getPage(), pageBean.getPageSize(),null);
		String pageCode = PageUtil.genPagination("page.html", totalNum, pageBean.getPage(), pageBean.getPageSize(),null);
		mav.addObject("pageCode", pageCode);
		User user = new User();
		HttpSession session = request.getSession();
		user = (User) session.getAttribute("currentUser");
		if (user!=null) {
			if (user.getUserName()!=null) {
				
			}else {
				user.setNickName("SaikiKuSuo");
				user.setDetails("2018年过了快一半了  还是没有钱");
				user.setHeadPortrait("qi.png");
			}
		}
		mav.addObject("currentUser", user);
		mav.setViewName("index");
		return mav;
	}

}
