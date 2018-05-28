package com.gao.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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

import com.gao.entity.Content;
import com.gao.entity.PageBean;
import com.gao.lucene.BlogIndex;
import com.gao.service.ContentService;
import com.gao.service.LeavingMessageService;
import com.gao.service.UserService;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/admin/content")
public class ContentAdminController {

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
