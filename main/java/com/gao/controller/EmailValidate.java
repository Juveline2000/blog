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

	// ������֤��
	@RequestMapping("/mail")
	public String email(String emailaddress,HttpServletResponse response){
		Random random = new Random();
		 StringBuffer code = new StringBuffer();
        for(int i = 0; i < 6;i++) {
           code.append(Math.abs(random.nextInt())%10);
        }					//cookie���� �ڻ�ȡ�е�   cookieֵ      trimȥ��ǰ��ո�
        Cookie cookie = new Cookie("code".trim(), code.toString().trim());  
        cookie.setMaxAge(5* 60);// ����Ϊ5min  
        cookie.setPath("/");  
        response.addCookie(cookie);
		sendEmail(emailaddress, code.toString());
		return null;
	}
	// ������֤��
		@SuppressWarnings("deprecation")
		public static boolean sendEmail(String emailaddress,String code){  
	        try {  
	        	HtmlEmail email = new HtmlEmail();//���ø���  
	            email.setHostName("smtp.163.com");//��Ҫ�޸ģ�126����Ϊsmtp.126.com,163����Ϊ163.smtp.com��QQΪsmtp.qq.com  
	            email.setSSL(true);
	            email.setCharset("UTF-8");  
	            email.addTo("gao1009522461@163.com");
	            email.addTo(emailaddress);// �ռ���ַ  
	            email.setFrom("gao1009522461@163.com", "Juveline");//�˴��������ַ���û���,�û�������������д  
	            email.setAuthentication("gao1009522461@163.com", "gaojiajun0303");//�˴���д�����ַ�Ϳͻ�����Ȩ��  
	            email.setSubject("��֤��");//�˴���д�ʼ������ʼ�����������д  
	            email.setMsg("<strong>�𾴵��û�����,������ע�����֤����(�������Ч��):<br><font color='red' size='20'>" + code+"</font></strong>");//�˴���д�ʼ�����  
	            email.send();  
	            return true;  
	        }  
	        catch(Exception e){  
	            e.printStackTrace();  
	            return false;  
	        }  
	    }
	}
