package com.gao.controller.admin;

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

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gao.entity.Content;
import com.gao.entity.Nav;
import com.gao.entity.PageBean;
import com.gao.service.ContentService;
import com.gao.service.LeavingMessageService;
import com.gao.service.NavService;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/admin/nav")
public class NavAdminController {

	@Resource
	NavService navService;
	@Resource
	LeavingMessageService leavingMessageService;
	@Resource
	ContentService contentService;
	/**
     * 表单提交日期绑定  不添加 当string类型 变成 date 类型会报错
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//写上你要的日期格式
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
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
		if (nav.getId()==null) {
			navService.add(nav);
		}else {
			navService.update(nav);
		}
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
				Map<String, Object>map = new HashMap<String, Object>();
				map.put("navId", strs[i]);
				List<Content> contentList = contentService.find(map);
				if (contentList.size()==0) {
					this.navService.delete(strs[i]);
					resultJson.put("success", true);
				}else {
					resultJson.put("success", false);
				}
			} catch (Exception e) {
				resultJson.put("success", false);
				e.printStackTrace();
			}
			ResponseUtil.write(response,resultJson);
		}
		return null;
	}
}
