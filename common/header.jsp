<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'header.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<style type="text/css">
.suggest_link_over {
	background-color: skyblue;
	padding: 2px 6px 2px 6px;
}

.suggest_link {
	background-color: #FFFFFF;
	padding: 2px 6px 2px 6px;
}

#suggest {
	position: absolute;
	background-color: #FFFFFF;
	text-align: left;
	border: 1px solid #000000;
	display: none;
	color:red;
}
.titleHome:hover{
	color:#ffffff!important;
}
</style>
<script type="text/javascript">
	function searchSome(){
		var search = $('#tr_search').val();
		if(search!=null&&search!=''){
			location.replace("${pageContext.request.contextPath }/content/q.html?q="+search);
		}
	}
	
</script>
</head>
<body>
	<hgroup id="ctn_header">
	<div id="title">
			
			<h1 id="site-title">
				<span><a href="${pageContext.request.contextPath }" title="blog" rel="home" class="titleHome">SaikiKuSuo</a></span>
			</h1>
			<h2 id="site-description">2018年过了快一半了  还是没有钱</h2>
	</div>
	<div id="title_r">
		<!-- 登陆 -->
		<c:choose>
			<c:when test="${currentUser.id!=null }">
				<a href="${pageContext.request.contextPath }/admin/user/userInfo.html"><button id="tr_admin"></button></a>
   			</c:when>
			<c:otherwise> 
				<a href="${pageContext.request.contextPath }/user/login.jsp" target="_blank"><button class="tr_profile"></button></a>
  			</c:otherwise>
		</c:choose>
		<span id="tr_clear"></span>
		<form id="tr_s_f" method="post" onsubmit="return false;">
			<input id="tr_search" type="text" name="search" size="20"
				onkeydown="if(event.keyCode==13) searchSome()" />
			<div id="suggest" style="width:200px;"></div>
		</form>

	</div>
	</hgroup>
</body>
<script type="text/javascript">
		$('.bar1').slideToUnlock();
		$('.bar2').slideToUnlock({
			height : 50,
			width : 200,
		});
		$('.bar3').slideToUnlock({
			height : 40,
			width : 300,
			text : '未解锁',
			succText : '解锁成功'
		});
		$('.bar4').slideToUnlock({
			bgColor : '#fce',
			progressColor : '#f60',
			succColor : '#f00',
			textColor : '#fff',
			succTextColor : '#fff',
		});
</script>
</html>
