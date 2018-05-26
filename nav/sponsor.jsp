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

<title>捐赠</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<script type="text/javascript">
	
</script>
</head>

<body>
	<div id="ctn" style="color:#666666;">
		<div id="content">
				<article
					class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">
				<hgroup class="post_hctn">
				<div class="post_h_l">
					<h2 class="post_h" >
						<a href="#" style="color:#69B5C9;" id="titles">赞助</a>
					</h2>
				</div>
				</hgroup> 
					<p>
						<h3>我就是来要钱的</h3>
						本人相信知识改变人生<br/>
						奋发图强 却敌不过拼爹的社会
					</p>
					<div align="center">
						<img alt="支付宝" width="45%" src="${pageContext.request.contextPath }/img/zfb.png">
						<img alt="微信" width="45%" src="${pageContext.request.contextPath }/img/wx.png">
					</div>
					
				</article>
		
		<jsp:include page="leavingmessage.jsp" />
		</div>
	</div>
</body>
</html>
