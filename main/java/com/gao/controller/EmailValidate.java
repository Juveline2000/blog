package com.gao.controller;

import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/email")
public class EmailValidate {

	// 邮箱验证码
	@RequestMapping("/mail")
	public String email(String emailaddress,HttpServletResponse response){
		Random random = new Random();
		 StringBuffer code = new StringBuffer();
        for(int i = 0; i < 6;i++) {
           code.append(Math.abs(random.nextInt())%10);
        }					//cookie名字 在获取中得   cookie值      trim去掉前后空格
        Cookie cookie = new Cookie("code".trim(), code.toString().trim());  
        cookie.setMaxAge(5* 60);// 设置为5min  
        cookie.setPath("/");  
        response.addCookie(cookie);
		sendEmail(emailaddress, code.toString());
		return null;
	}
	// 邮箱验证码
		@SuppressWarnings("deprecation")
		public static boolean sendEmail(String emailaddress,String code){  
	        try {  
	        	HtmlEmail email = new HtmlEmail();//不用更改  
	            email.setHostName("smtp.163.com");//需要修改，126邮箱为smtp.126.com,163邮箱为163.smtp.com，QQ为smtp.qq.com  
	            email.setSSL(true);
	            email.setCharset("UTF-8");  
	            email.addTo("gao1009522461@163.com");
	            email.addTo(emailaddress);// 收件地址  
	            email.setFrom("gao1009522461@163.com", "Juveline");//此处填邮箱地址和用户名,用户名可以任意填写  
	            email.setAuthentication("gao1009522461@163.com", "gaojiajun0303");//此处填写邮箱地址和客户端授权码  
	            email.setSubject("验证码");//此处填写邮件名，邮件名可任意填写  
	            email.setMsg("<strong>尊敬的用户您好,您本次注册的验证码是(五分钟有效期):<br><font color='red' size='20'>" + code+"</font></strong>");//此处填写邮件内容  
	            email.send();  
	            return true;  
	        }  
	        catch(Exception e){  
	            e.printStackTrace();  
	            return false;  
	        }  
	    }
	}
