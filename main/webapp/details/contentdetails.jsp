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
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCore.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCoreDefault.css"> --%>
	
</head>
<!-- <script type="text/javascript">
    SyntaxHighlighter.all();
</script> -->
<body>

	<div id="ctn" style="color:#666666;">
		<div id="content">

			<article class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">
			<!-- <div class="blog_share">
			<div class="bshare-custom"><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
		</div> -->
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
				<span class="post_ct" ><a href="${content.nav.url }?id=${content.nav.id}"
					rel="category tag"  style="color:#69B5C9;">${content.nav.nav }</a></span>
				<h2 class="post_h">
					<a href="${pageContext.request.contextPath }/details/${content.title }.html" style="color:#69B5C9;">${content.title }</a>
				</h2>

				<div class="post_tag">
					<span class="post_c"  ><a class="wp-postviews">${content.user.nickName }&nbsp;撰写</a></span>
					<script type="text/javascript">
						var tags = '${content.tag}';
						var result = tags.split(",");
						for(var i = 0;i<result.length;i++){
							document.write("<span class='post_c'><a class='wp-postviews' href='${pageContext.request.contextPath }/refurbish/list.do?tag="+result[i]+"'>"+result[i]+"</a></span>");
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
						<img src="${pageContext.request.contextPath }/img/user/${content.imgs}" alt="" width="100px" height="100px"/>
					</p>
				</c:if>
				<p>
					${content.comment }
				</p>
			</div>


			</article>
			<div>
				${pageCode }
			</div>
			<jsp:include page="../nav/leavingmessage.jsp" />
		</div>
	</div>
</body>
</html>