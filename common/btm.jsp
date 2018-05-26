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

<title>My JSP 'btm.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
</head>

<body class="home blog">
	<div id="sidebar">
		<%-- <div class="widget" id="one">
			<h2>近期文章</h2>
			<ul>
				<c:forEach var="topic" items="${blog.getAllBlog()}"
					varStatus="status">
					<li id="l${topic.getContentId()}"><a href="read.jsp?id=${topic.getContentId()}">${topic.getTitle()}</a></li>
				</c:forEach>
			</ul>
		</div> --%>
		<!-- <div class="widget" id="two">
			<h2>近期评论</h2>
			<ul id="recentcomments">
				<li class="recentcomments"><span class="comment-author-link">saber</span>发表在《<a
					href="#">fatego礼装——圣者的依代</a>》</li>
			</ul>
		</div> -->
	</div>


</body>
</html>
