package com.gao.entity;

public class User {

	private Integer id; //���
	private String userName; //��¼�˺�
	private String password; //��¼����
	private String nickName; //�ǳ�
	private String email; //����
	private Integer sex; //�Ա�
	private String phone; //�ֻ�
	private String headPortrait; //ͷ��
	private String details;//����ǩ��
	private Integer manage; //����
	
	
	public Integer getManage() {
		return manage;
	}
	public void setManage(Integer manage) {
		this.manage = manage;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getHeadPortrait() {
		return headPortrait;
	}
	public void setHeadPortrait(String headPortrait) {
		this.headPortrait = headPortrait;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
