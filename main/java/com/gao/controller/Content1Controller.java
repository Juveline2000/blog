package com.gao.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gao.entity.Content;
import com.gao.entity.LeavingMessage;
import com.gao.service.ContentService;
import com.gao.service.LeavingMessageService;
import com.gao.service.UserService;
import com.gao.util.DateUtil;
import com.gao.util.ResponseUtil;

@Controller
@RequestMapping("/")
public class Content1Controller {

	@Resource
	ContentService contentService;
	@Resource
	LeavingMessageService leavingMessageService;
	@Resource
	UserService userService;

	
	/*@RequestMapping("/list")
	public String list(Content content,HttpServletRequest request,String page){
		if (page==null) {
			page="1";
			request.getSession().setAttribute("content", content);
		}else{
			content = (Content)request.getSession().getAttribute("content");
		}
		PageBean pageBean = new PageBean(1, 5);
		Map<String, Object>contentMap = new HashMap<String, Object>();
		contentMap.put("start", pageBean.getStart());
		contentMap.put("size", pageBean.getPageSize());
		contentMap.put("comment", StringUtil.formatLike(content.getComment()));
		contentMap.put("title", StringUtil.formatLike(content.getTitle()));
		contentMap.put("userId", content.getId());
		List<Content>contentList = contentService.find(contentMap);
		List<User>userList = userService.list(null);
		request.setAttribute("contentList", contentList);
		request.setAttribute("userList", userList);
		Integer totalNum = contentService.getTotal(contentMap);
		String pageCode = PageUtil.genPagination("content/list.do", totalNum, 1, 5,null);
		request.setAttribute("pageCode", pageCode);
		request.setAttribute("mainPage", "manage/contentManage.jsp");
		return "index";
	}*/
	/***
	 * 删除
	 * @throws Exception 
	 * */
	@RequestMapping("/delete")
	public String delete(String sid,HttpServletResponse response) throws Exception{
		JSONObject resultJson = new JSONObject();
		contentService.delete(sid);
		ResponseUtil.write(response, resultJson);
		return null;
	}
	/**
	 * 点击 投稿时  保存
	 * */
	@RequestMapping("/save")
	public ModelAndView save(Content content,HttpServletRequest request,@RequestParam MultipartFile file) throws Exception{
		ModelAndView mav = new ModelAndView();
		if (file.getSize()!=0) {
			String imageName=DateUtil.getCurrentDateStr();
			String realPath=request.getSession().getServletContext().getRealPath("/img/user");
			String fileName = file.getOriginalFilename();
			String imageFile=imageName+"."+fileName.split("\\.")[1];
			File dir = new File(realPath, imageFile); 
			if(!dir.exists()){  
	            dir.mkdirs();  
	        }
			file.transferTo(dir);
			content.setImgs(imageFile);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		content.setCreateTime(DateUtil.formatString(date, "yyyy-MM-dd HH:mm:ss"));
		contentService.add(content);
		mav.setViewName("index");
		return mav;
	}
	
	
	/**
	 * 详情   点击 标签  进入  投稿作品详情页
	 * */
	@RequestMapping("/details/{title}")
	public ModelAndView details(Content content,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		request.getSession().setAttribute("title", "content/details.html?title="+content.getTitle()+"");
		request.getSession().setAttribute("contentTitle", "details"+content.getTitle()+".html");
		request.getSession().setAttribute("sendTitle", content.getTitle());
		mav.addObject("sendTitle", content.getTitle());
		Map<String, Object>map =new HashMap<String, Object>();
		map.put("commentPage", "content/details.html?title="+content.getTitle()+"");
		List<LeavingMessage>leavingMessagesList = leavingMessageService.find(map);
		mav.addObject("leavingMessagesList", leavingMessagesList);
		mav.addObject("mainPage", "details/contentdetails.jsp");
		Content content2 = contentService.findByTitle(content);
		content2.setClickHit(content2.getClickHit()+1);
		contentService.update(content2);
		if (content2.getComment().indexOf("<hr/>")!=-1) {
			content2.setComment(content2.getComment().replaceAll("<hr/>", ""));
		}
		mav.addObject("content", content2);
		mav.addObject("pageCode",getUpAndDownPageCode(content.getTitle()));
		mav.setViewName("index");
		return mav;
	}
	
	
	/***
	 * 获取上一篇 下一篇博客
	 * */
	public String getUpAndDownPageCode(String title){
		List<Content> contentList = contentService.find(null);
		int i = 0;
		int last = 0;
		int next = 0;
		for (Content content : contentList) {
			if (content.getTitle().equals(title)) {
				last = i-1;
				next = i+1;
				break;
			}
			i++;
		}
		StringBuffer param = new StringBuffer();
		param.append("<div style='width:100%;height:70px;'>");
		if (last!=-1) {
			Content c = contentList.get(last);
			System.out.println(c.getTitle());
			param.append("<div style='padding:10px!important; background-color:#69B5C9; float:left;'>"+"<span style='color:#fff;'>上一篇:</span><a style='color:#fff;' href='details/"+c.getTitle()+".html'>"+c.getTitle()+"</a>"+"</div>");
		}else {
			param.append("<div style='padding:10px!important; background-color:#69B5C9; float:left;'>"+"<span style='color:#fff;'>上一篇:暂无</span></div>");
		}
		if (next!=contentList.size()) {
		    Content n = contentList.get(next);
			System.out.println(n.getTitle());
			param.append("<div style='padding:10px!important; background-color:#69B5C9; float:right;'>"+"<span style='color:#fff;'>下一篇:</span><a style='color:#fff;' href='details/"+n.getTitle()+".html'>"+n.getTitle()+"</a>"+"</div>");
		}else {
			System.out.println("错误");
			param.append("<div style='padding:10px!important; background-color:#69B5C9; float:right;'>"+"<span style='color:#fff;'>下一篇:暂无</span></div>");
		}
		param.append("</div>");
		return param.toString();
	}
	
	
}
