package com.gao.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gao.controller.admin.DateJsonValueProcessor;
import com.gao.entity.Content;
import com.gao.entity.LeavingMessage;
import com.gao.entity.PageBean;
import com.gao.entity.User;
import com.gao.lucene.BlogIndex;
import com.gao.service.ContentService;
import com.gao.service.LeavingMessageService;
import com.gao.service.UserService;
import com.gao.util.DateUtil;
import com.gao.util.PageUtil;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/content")
public class ContentController {

	@Resource
	ContentService contentService;
	@Resource
	LeavingMessageService leavingMessageService;
	@Resource
	UserService userService;
	
	BlogIndex blogIndex = new BlogIndex();
	/**
     * 表单提交日期绑定  不添加 当string类型 变成 date 类型会报错
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//写上你要的日期格式
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	@RequestMapping("/list")
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
	}
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
	public ModelAndView save(Content content,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		content.setCreateTime(DateUtil.formatString(date, "yyyy-MM-dd HH:mm:ss"));
		contentService.add(content);
		blogIndex.addIndex(content);
		mav.setViewName("redirect:/index.html");
		return mav;
	}
	
	
	/**
	 * 详情   点击 标签  进入  投稿作品详情页
	 * */
	@RequestMapping("/details")
	public String details(String id,HttpServletRequest request){
		request.getSession().setAttribute("title", "content/details.do?id="+id+"");
		Map<String, Object>map =new HashMap<String, Object>();
		map.put("commentPage", "content/details.do?id="+id+"");
		List<LeavingMessage>leavingMessagesList = leavingMessageService.find(map);
		request.setAttribute("leavingMessagesList", leavingMessagesList);
		request.setAttribute("mainPage", "details/contentdetails.jsp");
		Content content = contentService.findById(Integer.valueOf(id));
		request.setAttribute("content", content);
		return "index";
	}
	
	
	
	@RequestMapping("/q")
	public ModelAndView search(String q,@RequestParam(value="page",required=false)String page,HttpServletRequest request) throws Exception{
		int pageSize = 5;
		if(StringUtil.isEmpty(page)){
			page="1";
		}
		ModelAndView mav = new ModelAndView();
		List<Content> contentList = blogIndex.searchContent(q);
		mav.addObject("mainPage", "common/search.jsp");
		Integer toIndex=contentList.size()>=Integer.parseInt(page)*pageSize?Integer.parseInt(page)*pageSize:contentList.size();
		mav.addObject("contentList",contentList.subList((Integer.parseInt(page)-1)*pageSize, toIndex));
		mav.addObject("pageCode",this.genUpAndDownPageCode(Integer.parseInt(page), contentList.size(), q,pageSize,request.getServletContext().getContextPath()));
		mav.addObject("q",q);
		mav.addObject("resultTotal",contentList.size());
		mav.addObject("pageTitle","搜索关键字'<font color='red'>"+q+"</font>' 共"+contentList.size()+" 条");
		mav.setViewName("index");
		return mav;
	}

	/**
	 * 获取上一页，下一页代码 查询博客用到
	 * @param page 当前页
	 * @param totalNum 总记录数
	 * @param q 查询关键字
	 * @param pageSize 每页大小
	 * @param projectContext
	 * @return
	 */
	private String genUpAndDownPageCode(Integer page,Integer totalNum,String q,Integer pageSize,String projectContext){
		long totalPage=totalNum%pageSize==0?totalNum/pageSize:totalNum/pageSize+1;
		StringBuffer pageCode=new StringBuffer();
		if(totalPage==0){
			return "";
		}else{
			pageCode.append("<nav>");
			pageCode.append("<ul class='pager' >");
			if(page>1){
				pageCode.append("<li><a href='"+projectContext+"/content/q.html?page="+(page-1)+"&q="+q+"'>上一页</a></li>");
			}else{
				pageCode.append("<li class='disabled'><a href='#'>上一页</a></li>");
			}
			if(page<totalPage){
				pageCode.append("<li><a href='"+projectContext+"/content/q.html?page="+(page+1)+"&q="+q+"'>下一页</a></li>");				
			}else{
				pageCode.append("<li class='disabled'><a href='#'>下一页</a></li>");				
			}
			pageCode.append("</ul>");
			pageCode.append("</nav>");
		}
		return pageCode.toString();
	}
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/backstageList")
	public String backstageList(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Content content,HttpServletResponse response) throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comment", StringUtil.formatLike(content.getComment()));
		map.put("title", StringUtil.formatLike(content.getTitle()));
		map.put("tag", StringUtil.formatLike(content.getTag()));
		if (content.getNav()!=null) {
			map.put("navId", content.getNav().getId());
		}
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Content>contentList = contentService.find(map);
		/*for (Content content2 : contentList) {
			if (content2.getComment().indexOf("<hr/>")!=-1) {
				content2.setComment(content2.getComment().substring(0, content2.getComment().indexOf("<hr/>")));;
			}
		}*/
		Integer total = contentService.getTotal(map);
		JSONObject result = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray = JSONArray.fromObject(contentList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 修改
	 * */
	@RequestMapping("/backstageUpdate")
	public String backstageUpdate(Content content,HttpServletResponse response)throws Exception{
		contentService.update(content);
		blogIndex.updateIndex(content);
		JSONObject result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/backstageDelete")
	public String backstageDelete(@RequestParam(value="ids",required=true)String ids,HttpServletResponse response) throws Exception{
		String[] strs  = ids.split(",");
		for (int i = 0; i < strs.length; i++) {
			JSONObject resultJson = new JSONObject();
			try {
				this.contentService.delete(strs[i]);
				blogIndex.deleteIndex(strs[i]);
				resultJson.put("success", true);
			} catch (Exception e) {
				resultJson.put("success", false);
				e.printStackTrace();
			}
			ResponseUtil.write(response,resultJson);
		}
		return null;
	}
	
}
