package com.gao.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gao.service.LinkService;

@Controller
@RequestMapping("/link")
public class LinkController {

	@Resource
	LinkService linkService;
	
	@RequestMapping("/find")
	public String find(HttpServletRequest request){
		
		return null;
	}
}
