<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>注册</title>

<link rel="icon" href="../img/icon6.ico" type="image/x-icon"/>    
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/Style/user.css">
 <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
 <script  type="text/javascript" src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
 <script  type="text/javascript" src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
</head>

<script type="text/javascript">
	$(function(){
		$('#login_error').hide();
		if('${register_error}'!=null&&'${register_error}'!=''){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>："+'${register_error}');
		}
	});
	
	function isSubmit(){
		var userName = $('#userName').val();
		var nickName = $('#nickName').val();
		var password = $('#password').val();
		var email = $('#email').val();
		var phone = $('#phone').val();
		var code = $('#code').val();
		var details = $('#details').val();
		if(userName ==null || userName == ""){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：账号不能为空");
			return false;
		}
		if(nickName ==null || nickName == ""){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：用户名不能为空");
			return false;
		}
		if(password ==null || password == ""){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：密码不能为空");
			return false;
		}
		if(email ==null || email == ""){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：邮箱不能为空");
			return false;
		}
		if(phone ==null || phone == ""){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：手机号不能为空");
			return false;
		}
		if(!isPoneAvailable(phone)){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong> 手机格式错误!");
		}
		if(details == null || details == ""){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：个人详情不能为空");
			return false;
		}
		if(!checkEmail(email)){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong> ：邮箱格式错误!");
			return false;
		}
		if(code==""||code==null){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong> ：验证码不能为空!");
			return false;
		}
		var emailCode=getCookie('code'); 
		if(emailCode!=code){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong> ：验证码错误!");
			return false;
		}
		$('#login_error').hide();
		return true;
	}
	
	function getCookie(name) {
		var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
		if (arr = document.cookie.match(reg))
			return unescape(arr[2]);
		else
			return null;
	}
	function isPoneAvailable(poneInput) {
		var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
		if (!myreg.test(poneInput)) {
			return false;
		} else {
			return true;
		}
	}

	function isEmail() {
		var email = $('#email').val();
		if (email == null || email == "") {
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>：邮箱不能为空");
			return false;
		}
		if (!checkEmail(email)) {
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong> ：邮箱格式错误!");
			return false;
		}
		return true;
	}
	function checkEmail(str) {
		var re = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
		if (re.test(str)) {
			return true;
		} else {
			return false;
		}
	}
	var wait = 60;
	var flag = true;
	function time(o) {
		if (isEmail()) {
			if (flag) {
				var email = $('#email').val();
				$.post("${pageContext.request.contextPath }/email/mail.do", {
					emailaddress : email
				}, function() {
				});
			}
			if (wait == 0) {
				o.removeAttribute("disabled");
				o.value = "获取验证码";
				wait = 60;
				flag = true;
			} else {
				o.setAttribute("disabled", true);
				o.value = "重新发送(" + wait + ")";
				wait--;
				setTimeout(function() {
					time(o);
				}, 1000);
				flag = false;
			}
		}
	}
	document.getElementById("btn").onclick = function() {
		time(this);
	}
</script>
</head>

<body class="login">
	<div id="login">
		<p><img alt="" src="img/user/gif3.gif" id="loginImg"></p><br/>
		<div id="login_error">	</div>
		<form name="loginform" id="loginform" action="${pageContext.request.contextPath }/user/register.do" method="post" onsubmit="return isSubmit()" enctype="multipart/form-data">
			<p>
				<label for="user_login">账号<br /> <input type="text"
					name="userName" id="userName" class="input" value="${user.userName }" size="20" />
				</label>
			</p>
			<p>
				<label for="user_login">用户名<br /> <input type="text"
					name="nickName" id="nickName" class="input" value="${user.nickName }" size="20" />
				</label>
			</p>
			<p>
				<label for="user_pass">密码<br /> <input type="password"
					name="password" id="password" class="input" value="${user.password }" size="20" />
				</label>
			</p>
			<p>
				<label for="user_login">电子邮箱<br /> <input type="text"
					name="email" id="email" class="input" value="${user.email }" size="20" />
				</label>
			</p>
			<p>
				<label for="user_login">电话号码<br /> <input type="text"
					name="phone" id="phone" class="input" value="${user.phone }" size="20" />
				</label>
			</p>
			<p>
				<label for="user_login">性别<br /> 
				<label>男:</label> &nbsp;<input type="radio" name="sex" value="1" style="margin-right:10px;" checked="checked"/>
				<label>女:</label> &nbsp;<input type="radio" name="sex" value="0" />
				</label>
			</p>
			<p>
				<label for="user_login">个人简介<br /> <input type="text"
					name="details" id="details" class="input" value="${user.details }" size="20" />
				</label>
			</p>
			<p>
				<label for="user_login">头像<br /> 
				<input type="file" name="file" class="contributeInput" style="width:60%;"/> <font color="red" style="width:5%;font-size:11px;">可不上传图片</font>
				</label>
			</p>
			<br>
			<p>
				<label for="user_login">验证码<font color="red">(邮箱验证)</font><br /> <input type="text"
					name="code" id="code" class="input" style="width:50%;" /><input type="button" onclick="time(this)" id="btn" value="获取验证码" style="padding:5px;"/>
				</label>
			</p>
			<p class="forgetmenot">
			</p>
			<p class="submit">
				<input type="submit" name="wp-submit" id="wp-submit"
					class="button button-primary button-large" value="注册" />
			</p>
		</form>


	</div>
	<div class="clear"></div>
	<br/>
	<br/>
	<br/>
</body>
<script type="text/javascript">
	if('${register_error}'!=null&&'${register_error}'!=''){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong>："+'${register_error}');
		}
</script>
</html>
