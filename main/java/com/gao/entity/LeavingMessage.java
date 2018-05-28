package com.gao.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class LeavingMessage {

	
	private Integer id; //�ظ�id
	private String commentPage;//����ҳ��
	private String commentNickName;//��������
	private String reviewcontent;//��������
	private Date commentTime;//����ʱ��
	private String commentEmail;//��������
	private List<Reply> replyList = new ArrayList<Reply>();
	
	
	public String getCommentEmail() {
		return commentEmail;
	}
	public void setCommentEmail(String commentEmail) {
		this.commentEmail = commentEmail;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCommentPage() {
		return commentPage;
	}
	public void setCommentPage(String commentPage) {
		this.commentPage = commentPage;
	}
	public String getCommentNickName() {
		return commentNickName;
	}
	public void setCommentNickName(String commentNickName) {
		this.commentNickName = commentNickName;
	}
	public String getReviewcontent() {
		return reviewcontent;
	}
	public void setReviewcontent(String reviewcontent) {
		this.reviewcontent = reviewcontent;
	}
	public Date getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}
	public List<Reply> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}
	
	
}
