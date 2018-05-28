package com.gao.controller;




import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;









import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gao.entity.LeavingMessage;
import com.gao.entity.Reply;
import com.gao.service.LeavingMessageService;
import com.gao.service.ReplyService;
import com.gao.util.DateUtil;

@Controller
@RequestMapping("/leavingMessage")
public class LeavingMessageController {

	@Resource
	LeavingMessageService leavingMessageService;
	@Resource
	ReplyService replyService;
	
	
	/**
	 * 用户评论 
	 * @throws Exception 
	 * */
	@RequestMapping("/save")
	public ModelAndView save(HttpServletRequest request,LeavingMessage leavingMessage) throws Exception{
		ModelAndView mav = new ModelAndView();
		leavingMessage.setCommentPage((String)request.getSession().getAttribute("title"));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		leavingMessage.setCommentTime(DateUtil.formatString(date, "yyyy-MM-dd HH:mm:ss"));
		leavingMessageService.save(leavingMessage);
		System.out.println(request.getSession().getAttribute("contentTitle"));
		String title = (String) request.getSession().getAttribute("contentTitle"); 
		try{
		    title = java.net.URLEncoder.encode(title,"UTF-8");  
			title = title.replace(" ", "%2B");
			title = title.replace("+", "%20");
		}catch(Exception ex){   
		    ex.printStackTrace();  
		}
		title = title.replaceAll("details", "details/");
		System.out.println(title);
		mav.setViewName("redirect:/"+title);
		return mav;
	}

	/**
	 * 用户回复 评论
	 * */
	@RequestMapping("/replysave")
	public ModelAndView replysave(HttpServletResponse response,HttpServletRequest request,String commentId,LeavingMessage leavingMessage) throws Exception{
		ModelAndView mav = new ModelAndView();
		Reply reply = new Reply();
		reply.setCommentId(Integer.valueOf(commentId));
		reply.setComment(leavingMessage.getReviewcontent());
		reply.setReplyName(leavingMessage.getCommentNickName());
		reply.setReplyEmail(leavingMessage.getCommentEmail());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		reply.setReplyTime(DateUtil.formatString(date, "yyyy-MM-dd HH:mm:ss"));
		replyService.save(reply);
		String title = (String) request.getSession().getAttribute("contentTitle"); 
		System.out.println(title);
		try{
		    title = java.net.URLEncoder.encode(title,"UTF-8");//修改url 传入中文时不乱吗  
			title = title.replace(" ", "%2B");
			title = title.replace("+", "%20");
		}catch(Exception ex){  
		    ex.printStackTrace();  
		}  
		title = title.replaceAll("details", "details/");
		mav.setViewName("redirect:/"+title);
		return mav;
	}
}
