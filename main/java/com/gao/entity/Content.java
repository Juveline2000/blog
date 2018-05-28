package com.gao.entity;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;


public class Content {

	private Integer id; //评论id
	private User user;//用户id
	private String comment;//评论内容
	private String commentNoTag;//评论内容 没标签
	private String title;//标题
	private Date createTime;//评论时间
	private Nav nav;//标签id
	private String imgs;//图片
	private String tag;//标签
	private Integer clickHit; //点击访问
	private List<String> imageList = new LinkedList<String>();//博客里到了图片

	private String createTimeStr;//评论时间
	
	public String getCommentNoTag() {
		return commentNoTag;
	}
	public void setCommentNoTag(String commentNoTag) {
		this.commentNoTag = commentNoTag;
	}
	public String getCreateTimeStr() {
		return createTimeStr;
	}
	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}
	public Integer getClickHit() {
		return clickHit;
	}
	public void setClickHit(Integer clickHit) {
		this.clickHit = clickHit;
	}
	public List<String> getImageList() {
		return imageList;
	}
	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Nav getNav() {
		return nav;
	}
	public void setNav(Nav nav) {
		this.nav = nav;
	}
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	
	
}
