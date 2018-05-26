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

<title>登录</title>
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
	
</script>
<body class="login">
	<div id="login">
		<p><img alt="" src="img/user/gif3.gif" id="loginImg"></p><br/>
		<div id="login_error" style="display: none;">	<strong>错误</strong>：</div>
		<form name="loginform" id="loginform" action="${pageContext.request.contextPath }/user/login.do" method="post" onsubmit="return logins()">
			<p>
				<label for="user_login">账号/电子邮件地址/手机号<br /> <input type="text"
					name="userName" id="user_login" class="input" value="" size="20" />
				</label>
			</p>
			<p>
				<label for="user_pass">密码<br /> <input type="password"
					name="password" id="user_pass" class="input" value="" size="20" />
				</label>
			</p>
			<p class="forgetmenot">
				<label for="rememberme">没有账号？去<a href="${pageContext.request.contextPath }/user/register.jsp" style="color: #6CB6E8; text-decoration:none;">注册</a></label>
			</p>
			<p class="submit">
				<input type="submit" name="wp-submit" id="wp-submit"
					class="button button-primary button-large" value="登录" /> <input
					type="hidden" name="redirect_to"
					value="https://saber.love/wp-admin/" /> <input type="hidden"
					name="testcookie" value="1" />
			</p>
			<p id="nav">
				
			</p>
		</form>


	</div>
	<div class="clear"></div>
	<script type="text/javascript">
		if('${errorMsg}'){
			$('#login_error').show();
			$('#login_error').html("<strong>错误</strong> : "+'${errorMsg}');
		}
		
		function logins(){ 
			if($('#user_login').val()==null || $('#user_login').val()==''){
				$('#login_error').show();
				$('#login_error').html("<strong>错误</strong> : "+'用户名不能为空');
				return false;
			}
			if($('#user_pass').val()==null || $('#user_pass').val()==''){
				$('#login_error').show();
				$('#login_error').html("<strong>错误</strong> : "+'密码不能为空');
				return false;
			}
			$('#login_error').hide();
			return true;
		}
		
	</script>
</body>
</html>
