package com.gao.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gao.entity.User;
import com.gao.entity.PageBean;
import com.gao.service.UserService;
import com.gao.util.CryptographyUtil;
import com.gao.util.DateUtil;
import com.gao.util.PageUtil;
import com.gao.util.PropertiesUtil;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/user")
public class UserController {

	
	@Resource
	UserService userService;
	
	/**
	 * 显示  后台
	 * */
	@RequestMapping("/list")
	public String list(User user,HttpServletRequest request,String page){
		
		HttpSession session = request.getSession();
		if (page==null) {
			page = "1";
			session.setAttribute("user", user);
		}else{
			user = (User)session.getAttribute("user");
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("pageSize")));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", StringUtil.formatLike(user.getUserName()));
		map.put("nickName", StringUtil.formatLike(user.getNickName()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User>userList = userService.list(map);
		Integer total = userService.getTotal(map);
		String pageCode = PageUtil.genPagination("user/list.do", total, Integer.parseInt(page), pageBean.getPageSize(),null);
		request.setAttribute("userList", userList);
		request.setAttribute("pageCode", pageCode);
		request.setAttribute("mainPage", "manage/userManage.jsp");
		return "index";
	}
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
	
	/***
	 * 删除
	 * @throws Exception 
	 * */
	@RequestMapping("/delete")
	public String delete(String sid,HttpServletResponse response) throws Exception{
		JSONObject resultJson = new JSONObject();
		userService.delete(sid);
		ResponseUtil.write(response, resultJson);
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
	 * 登录
	 * */
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request){
		//判断是邮箱还是手机号的正则表达式  
        String em = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";  
        String ph = "^[1][34578]\\d{9}$"; 
        if(user.getUserName().matches(ph)){//手机号登录  
        	user.setPhone(user.getUserName());
        	user.setUserName(null);
        }
        if(user.getUserName()!=null && user.getUserName().matches(em)){//邮箱登录  
        	user.setEmail(user.getUserName());
        	user.setUserName(null);
        }
        user.setPassword(CryptographyUtil.md5(user.getPassword(), "gao"));
		User userResult = userService.login(user);
		if (userResult==null) {
			request.setAttribute("user", user);
			request.setAttribute("errorMsg", "用户名,密码或用户类型错误");
			return "user/login";
		}else{
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", userResult);
			return "redirect:/index.html";
		}
	}
	
	/**
	 * 注册
	 * */
	@RequestMapping("/register")
	public String register(User user,HttpServletRequest request,@RequestParam MultipartFile file) throws Exception{
		User u = userService.findByName(user);
		if (u!=null) {
			request.setAttribute("user", user);
			request.setAttribute("register_error", "已有相同的账户");
			return "forward:/user/register.jsp";
		}else{
			if (file.getSize()!=0) {
				String imageName=DateUtil.getCurrentDateStr();
				String realPath=request.getSession().getServletContext().getRealPath("/img");
				String fileName = file.getOriginalFilename();
				String imageFile=imageName+"."+fileName.split("\\.")[1];
				File dir = new File(realPath, imageFile); 
				if(!dir.exists()){  
		            dir.mkdirs();  
		        }
				file.transferTo(dir);
				user.setHeadPortrait(imageFile);
			}else{
				user.setHeadPortrait("1.jpg");
			}
	        user.setPassword(CryptographyUtil.md5(user.getPassword(), "gao"));
			userService.register(user);
			return "redirect:/user/login.jsp";
		}
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
	 * 修改用户
	 * */
	@RequestMapping("/save")
	public String save(User user,HttpServletRequest request,@RequestParam MultipartFile file) throws Exception{
		if (file.getSize()!=0) {
			String imageName=DateUtil.getCurrentDateStr();
			String realPath=request.getSession().getServletContext().getRealPath("/img");
			String fileName = file.getOriginalFilename();
			String imageFile=imageName+"."+fileName.split("\\.")[1];
			File dir = new File(realPath, imageFile); 
			if(!dir.exists()){  
	            dir.mkdirs();  
	        }
			file.transferTo(dir);
			user.setHeadPortrait(imageFile);
		}
		if (!user.getPassword().equals("")) {
			user.setPassword(CryptographyUtil.md5(user.getPassword(), "gao"));
		}
		userService.update(user);
		if (user.getHeadPortrait()==null) {
			User u = (User)request.getSession().getAttribute("currentUser");
			user.setHeadPortrait(u.getHeadPortrait());
		}
		request.getSession().setAttribute("currentUser", user);
		request.setAttribute("mainPage", "user/userInfo.jsp");
		return "index";
	}
	@RequestMapping("/loginOut")
	public String loginOut(HttpServletRequest request) throws Exception{
		request.getSession().removeAttribute("currentUser");
		return "index";
	}
	
}
