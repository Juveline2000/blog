<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<title>My JSP 'float.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<style type="text/css">
	.a{
		color:#fff!important;
		cursor:pointer!important;
		onmouseover:this.style.cursor='hand'!important;
	}
	.a:hover{
		color:#63BAD0!important;
		cursor:pointer!important;
	}
</style>
</head>
<body>
	<footer id="footer" role="contentinfo" style="color:#fff;">
		友情链接
		<br/>
		<c:forEach var="link" items="${linkList }" varStatus="status">
			<div><a class="a" target="view_window" href="${link.linkUrl }">${link.linkName }</a></div>
		</c:forEach>
	</footer>
</body>
</html>
