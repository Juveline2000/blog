<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>My JSP 'content.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/bootstrap.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCore.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCoreDefault.css">
<script type="text/javascript">
    SyntaxHighlighter.all();
</script>
</head>

<body>

	<div id="ctn" style="color:#666666;">
		<div id="content">
			<div>${pageTitle }</div>
			<c:forEach items="${contentList }" var="content" varStatus="status">
			<article class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">

			<hgroup class="post_hctn">
			<div class="post_h_l">
			</div>
			<!-- 时间 -->
			<div class="post_time">
				<div class="post_t_d"><fmt:formatDate value="${content.createTime }" pattern="MM/dd"/></div>
				<div class="post_t_u"><fmt:formatDate value="${content.createTime }" pattern="HH:mm"/></div>
			</div>
			<!-- title -->
			<div class="post_h_l">
				<h2 class="post_h">
					<%-- <a href="${pageContext.request.contextPath }/content/details.do?id=${content.id }" style="color:#69B5C9;">${content.title }</a> --%>
					<input type="hidden" value="${content.title }" id="titleInp${status.index }"/>
					
					<a id="detailsA${status.index }" href="${pageContext.request.contextPath }/details/.html" style="color:#69B5C9;">${content.title }</a>
					<script type="text/javascript">
						var regx = /<[^>]*>|<\/[^>]*>/gm;
						var tagStr = $("#titleInp"+${status.index}+"").val();
						var result = tagStr.replace(regx,"");
						$("#detailsA"+${status.index}+"").attr('href',"${pageContext.request.contextPath }/details/"+result+".html"); 
					</script>
				</h2>

				<div class="post_tag">
					<br/>
				</div>
			</div>
			</hgroup>

			<div class="post_t">
				<c:if test="${content.imgs!=null }">
					<!-- 可放图片 -->
					<p>
						<img src="${pageContext.request.contextPath }/img/user/${content.imgs}"/>
					</p>
				</c:if>
				${content.comment }
				<br/>
				<br/>
				<div><a id="movement${status.index }" href="${pageContext.request.contextPath }/details/${content.title }.html" style="color:#FFFFFF; background:#82B2D2;padding:7;font-size:13px;">→Jump movement</a></div>
				<script type="text/javascript">
						var regx = /<[^>]*>|<\/[^>]*>/gm;
						var tagStr = $("#titleInp"+${status.index}+"").val();
						var result = tagStr.replace(regx,"");
						$("#movement"+${status.index}+"").attr('href',"${pageContext.request.contextPath }/details/"+result+".html"); 
					</script>
			</div>


			</article>
			</c:forEach>
			
			<div align="center">
    			${pageCode}
    		</div>
		</div>
	</div>
</body>
</html>