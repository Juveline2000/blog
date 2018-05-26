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
</head>

<body >
	<%-- <img src="${pageContext.request.contextPath}/img/1.jpg" id="logo"/> --%>
	
	<div id="float">
		<a href="${pageContext.request.contextPath }" title="${currentUser.userName }" rel="home"><img id="logo" width="100px" alt="DDbolg" title="${currentUser.userName }" src="${pageContext.request.contextPath }/img/${currentUser.headPortrait}"></a>

		<c:choose>
			<c:when test="${currentUser.manage==1 }">  
				<nav id="nav" role="navigation">
				<div class="menu">
					<ul>
						<li><a href="${pageContext.request.contextPath }/user/list.do">用户管理</a></li>
						<li><a href="${pageContext.request.contextPath }/content/list.do">投稿管理</a></li>
					</ul>
				</div>
				</nav>
			</c:when>
			<c:otherwise> 
				<nav id="nav" role="navigation">
				<div class="menu">
					<ul>
							<li class="page_item page-item-2166"><a href="${pageContext.request.contextPath }">首页</a></li>
							<c:forEach items="${navList }" var="nav">
								<c:if test="${nav.tag==0 }">
									<li class="page_item page-item-2166"><a href="${nav.url }?id=${nav.id}">${nav.nav }</a></li>
								</c:if>
							</c:forEach>
					</ul>
				</div>
				</nav>
				<nav id="next" role="sencond_navigation">
				<div class="menu">
					<ul>
						<c:forEach items="${navList }" var="nav">
							<c:if test="${nav.tag==1 }">
								<li class="page_item page-item-3909"><a href="${pageContext.request.contextPath }/${nav.url }">${nav.nav }</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				</nav>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
