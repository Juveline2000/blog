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

	
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
</head>

<body>
	<div id="ctn" style="color:#666666;margin-top:0!important;">
		<div id="content">
		<c:forEach var="logDate" items="${logDateList }" varStatus="status">
			<span style="padding-right:7%;"><b><a href="${pageContext.request.contextPath }/page.html?comment=${logDate.currentDate }" style="color:#63BAD0;">${logDate.currentDate }(${logDate.sum })</a></b></span>
		</c:forEach>
		</div>
	</div>
</body>
</html>
