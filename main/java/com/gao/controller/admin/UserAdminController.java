package com.gao.controller.admin;

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

import com.gao.entity.User;
import com.gao.entity.PageBean;
import com.gao.service.UserService;
import com.gao.util.CryptographyUtil;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/admin/user")
public class UserAdminController {

	
	@Resource
	UserService userService;
	
	/**
	 * 显示  后台
	 * */
	
	@RequestMapping("/backstageList")
	public String backstageList(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,User user,HttpServletResponse response) throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", StringUtil.formatLike(user.getUserName()));
		map.put("nickName", StringUtil.formatLike(user.getNickName()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User>userList = userService.list(map);
		Integer total = userService.getTotal(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(userList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	
	@RequestMapping("/backstageDelete")
	public String backstageDelete(@RequestParam(value="ids",required=true)String ids,HttpServletResponse response) throws Exception{
		String[] strs  = ids.split(",");
		for (int i = 0; i < strs.length; i++) {
			JSONObject resultJson = new JSONObject();
			try {
				this.userService.delete(strs[i]);
				resultJson.put("success", true);
			} catch (Exception e) {
				resultJson.put("success", false);
				e.printStackTrace();
			}
			ResponseUtil.write(response,resultJson);
		}
		return null;
	}
	
	/**
	 * 用户中心
	 * */
	@RequestMapping("/userInfo")
	public String userInfo(HttpServletRequest request) throws Exception{
		request.setAttribute("mainPage", "user/userInfo.jsp");
		return "index";
	}
	
	/**
	 * 修改
	 * */
	@RequestMapping("/update")
	public String update(User user,HttpServletRequest request,HttpServletResponse response) throws Exception{
		if (!user.getPassword().equals("")) {
			user.setPassword(CryptographyUtil.md5(user.getPassword(), "gao"));
		}
		userService.update(user);
		JSONObject result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
