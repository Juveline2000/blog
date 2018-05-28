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

import com.gao.entity.LeavingMessage;
import com.gao.entity.PageBean;
import com.gao.service.LeavingMessageService;
import com.gao.service.ReplyService;
import com.gao.util.ResponseUtil;
import com.gao.util.StringUtil;

@Controller
@RequestMapping("/admin/leavingMessage")
public class LeavingMessageAdminController {

	@Resource
	LeavingMessageService leavingMessageService;
	@Resource
	ReplyService replyService;
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
	public String backstageList(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,LeavingMessage leavingMessage,HttpServletResponse response) throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewcontent", StringUtil.formatLike(leavingMessage.getReviewcontent()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<LeavingMessage>leavingMessageList = leavingMessageService.find(map);
		Long total = leavingMessageService.getTotal(map);
		JSONObject result = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray = JSONArray.fromObject(leavingMessageList,jsonConfig);
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
				this.leavingMessageService.delete(strs[i]);
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
