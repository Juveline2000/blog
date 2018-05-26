<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCore.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCoreDefault.css">
<script type="text/javascript">
    SyntaxHighlighter.all();
</script> --%>
</head>

<body>


	<c:forEach items="${contentList }" var="content"  varStatus="status">
	
		<div id="ctn" style="<c:if test="${status.index!=0}">margin-top:0!important;</c:if> color:#666666;">
			<div id="content">
			<article>
			<hgroup class="post_hctn">
			
			<!-- 时间 -->
			<div class="post_time">
				<div class="post_t_d"><fmt:formatDate value="${content.createTime }" pattern="MM/dd"/></div>
				<div class="post_t_u"><fmt:formatDate value="${content.createTime }" pattern="HH:mm"/></div>
			</div>
			<!-- title -->
			<div class="post_h_l">
				<span class="post_ct" ><a href="${content.nav.url }?id=${content.nav.id}"
					rel="category tag"  style="color:#69B5C9;">${content.nav.nav }</a></span>
				<h2 class="post_h">
					<%-- <a href="${pageContext.request.contextPath }/content/details.do?id=${content.id }" style="color:#69B5C9;">${content.title }</a> --%>
					
					<a href="${pageContext.request.contextPath }/details/${content.title }.html" style="color:#69B5C9;">${content.title }</a>
				</h2>

				<div class="post_tag">
					<span class="post_c"  ><a class="wp-postviews">${content.user.nickName }&nbsp;撰写</a></span>
					<script type="text/javascript">
						var tags = '${content.tag}';
						var result = tags.split(",");
						for(var i = 0;i<result.length;i++){
							document.write("<span class='post_c'><a class='wp-postviews' href='${pageContext.request.contextPath }/page.html?tag="+result[i]+"'>"+result[i]+"</a></span>");
						}
					</script>
					<span class='post_c'><a class='wp-postviews' href=''>${content.clickHit }次浏览</a></span>
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
				
				<a href="${pageContext.request.contextPath }/details/${content.title }.html" style="color:#FFFFFF; background:#82B2D2;padding:7;font-size:13px;">→Jump movement</a>
			</div>


			</article>
			
				</div>
			</div>
		</c:forEach>
			<div id="ctn" style="margin-top:0!important; color:#666666;">
				<div align="center">
			    		<ul class="pagination">
			    			${pageCode}
			    		</ul>
	    		</div>
    		</div>
</body>
</html>