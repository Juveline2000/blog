package com.gao.entity;

import java.util.Date;

public class Reply {

	private Integer id; //回复id
	private Integer commentId;//回复人id
	private String replyName;//回复人昵称
	private String comment;//回复内容
	private Date replyTime;//回复时间
	private String replyEmail;
	private LeavingMessage leavingMessage;
	
	
	public LeavingMessage getLeavingMessage() {
		return leavingMessage;
	}
	public void setLeavingMessage(LeavingMessage leavingMessage) {
		this.leavingMessage = leavingMessage;
	}
	public String getReplyEmail() {
		return replyEmail;
	}
	public void setReplyEmail(String replyEmail) {
		this.replyEmail = replyEmail;
	}
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCommentId() {
		return commentId;
	}
	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}
	public String getReplyName() {
		return replyName;
	}
	public void setReplyName(String replyName) {
		this.replyName = replyName;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
}
