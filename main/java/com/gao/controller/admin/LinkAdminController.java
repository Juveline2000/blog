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

import com.gao.entity.Link;
import com.gao.entity.PageBean;
import com.gao.service.LinkService;
import com.gao.util.ResponseUtil;

@Controller
@RequestMapping("/admin/link")
public class LinkAdminController {

	@Resource
	LinkService linkService;
	/**
     * 表单提交日期绑定  不添加 当string类型 变成 date 类型会报错
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//写上你要的日期格式
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	@RequestMapping("/find")
	public String find(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpServletRequest request) throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Link> linkList = linkService.find(map);
		Integer total = linkService.getTotal(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(linkList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/add")
	public String add(Link link,HttpServletRequest request,HttpServletResponse response) throws Exception{
		if (link.getId()==null) {
			linkService.add(link);
		}else {
			linkService.update(link);
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
				this.linkService.delete(strs[i]);
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
