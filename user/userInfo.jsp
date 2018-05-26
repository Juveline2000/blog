<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>管理</title>

	<link rel="icon" href="../img/icon6.ico" type="image/x-icon"/>    
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">

<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/utf8-jsp/ueditor.all.min.js"></script>
	
 <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
 <script  type="text/javascript" src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
 <script  type="text/javascript" src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript">
		function isSubmit(){
			var title = $('#titles').val();
			var userId = $('#userId').val();
			var userEmail = $('#userEmail').val();
			var value = $("#slider").slider( "option", "value" );  
			var conent = ue.getContent();
			if(title==null || title==""){
				$('#error').html("标题不能为空!");
				return false;
			}
			if(userId==null || userId==""){
				$('#error').html("请先登录在投稿!");
				return false;
			}
			if(userEmail==null || userEmail==""){
				$('#error').html("邮箱不能为空!");
				
				return false;
			}
			if(conent==null || conent==""){
				$('#error').html("内容不能为空!");
				return false;
			}
			if(!checkEmail(userEmail)){
				$('#error').html("邮箱格式错误!");
				return false;
			}
			if(value!=100){
				$('#error').html("请把解锁划至最右边!");
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
		
		function loginOut(){
			if(confirm("是否退出登录")){
				window.location.href = "${pageContext.request.contextPath }/user/loginOut.do";
			}
		}
	</script>
</head>

<body>
	<div id="ctn" style="color:#666666;">
		<div id="content">
			<button style="border:1px solid #AAAAAA; background: #E6E6E6;" onclick="loginOut()">退出登录</button>
			<form action="${pageContext.request.contextPath}/user/save.do" method="post" onsubmit="return isSubmit()" enctype="multipart/form-data">

				<article
					class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">
				<hgroup class="post_hctn">
				<div class="post_h_l">
					<h2 class="post_h">
						<a href="#" style="color:#69B5C9;">个人中心</a>
					</h2>
				</div>
				</hgroup> 
				
				<p>
					<label style="width: 70px;float: left;">账户</label>
					<input type="text" id="titles" name="userName" value="${currentUser.userName}" maxlength="50" class="contributeInput" readonly="readonly"/> <font color="red" style="width:10%;font-size:11px;">*只读 不能修改</font>
				</p>
				<p>
					<label style="width: 70px;float: left;">昵称</label>
					<input type="text" id="userId" class="contributeInput"name="nickName" value="${currentUser.id==null?'':currentUser.nickName }"/> 
					<input type="hidden" name="id" value="${currentUser.id}"/>
				</p>
				<p>
					<label style="width: 70px;float: left;">密码</label>
					<input type="text" id="userId" class="contributeInput"name="password"/> 
				</p>
				<p>
					<label style="width: 70px;float: left;">E-mail</label>
					<input type="text" id="userEmail" name="email" value="${currentUser.email}" class="contributeInput"/>
				</p>
				<p>
					<label style="width: 70px;float: left;">手机</label>
					<input type="text" id="userEmail" name="phone" value="${currentUser.phone}" maxlength="11" class="contributeInput"/>
				</p>
				<p>
					<label style="width: 70px;float: left;">更换头像</label>
					<input type="file" name="file" class="contributeInput"/> <font color="red" style="width:10%;font-size:11px;">可不上传图片</font>
				</p>
				<p>
					<label for="user_login">性别&nbsp;&nbsp;&nbsp;
					<label>男:&nbsp;<input type="radio" name="sex" value="1" style="margin-right:10px;" checked="checked"/></label> 
					<label>女:&nbsp;<input type="radio" name="sex" value="0" /></label> 
					</label>
				</p>
				<p>
					<label style="width: 70px;float: left;">个性签名</label> <font color="red" style="width:10%;font-size:11px;">*不能超过100字</font><br/>
					<textarea name="details" id="comment" style="width: 55%; height: 150px;background-attachment:fixed;background-repeat:no-repeat;border-style:solid; border-color:#A2A2A2;color:#999999;"> ${currentUser.details}</textarea> 
				</p>
				
				<p>
					<font color="red" id="error"></font>
					<br/>
					<input type="submit" value="提交" style="border:1px solid #AAAAAA; background: #E6E6E6;">
				</p>
				</article>

			</form>
		</div>
	</div>
</body>
</html>
