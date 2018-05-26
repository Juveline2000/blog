<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'contribute.jsp' starting page</title>

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
<script type="text/javascript">
	//平台、设备和操作系统   
			var system ={  
			win : false,  
			mac : false,  
			xll : false  
			};  
			//检测平台   
			var p = navigator.platform;  
			system.win = p.indexOf("Win") == 0;  
			system.mac = p.indexOf("Mac") == 0;  
			system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);  
			//跳转语句   
			if(system.win||system.mac||system.xll){ //转向电脑端
			}else{  
			}
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/utf8-jsp/ueditor.all.min.js"></script>
	
<link rel="stylesheet" href="jqueryui/style.css">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/bootstrap.min.css">
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript">
		 function deletes(id){
			if(confirm("是否要删除该投稿")){
				$.post("${pageContext.request.contextPath }/content/delete.do",{sid : id},function(result) {
					alert("删除成功！");
					location.reload();
				});
			}
		} 
	</script>
</head>

<body>
	<div id="ctn" style="color:#666666;">
		<div id="content">
				<article
					class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">
				<hgroup class="post_hctn">
				<div class="post_h_l">
					<h2 class="post_h">
						<a href="#" style="color:#69B5C9;">投稿管理</a>
					</h2>
				</div>
				</hgroup> 
				
				<form action="${pageContext.request.contextPath }/content/list.do" method="post" style="margin-top:10px; color:#E06495;">
					<label>标题:</label><input type="text" name="title" value="${content.title }" style="border:1px solid #E06495;color:#E06495;"/>
					<label>内容:</label><input type="text" name="comment" value="${content.comment }" style="border:1px solid #E06495;color:#E06495;"/>
					<label>昵称:</label><select name="id"><option value="0">请选择...</option><c:forEach var="user" items="${userList }" varStatus="status"><option value="${user.id }">${user.nickName }</option></c:forEach></select>
					<input type="submit" value="搜索" style="border:1px solid #E06495;color:#E06495;background: #E6E6E6;"/>
				</form>
				
				<table border="1px" style="color:#E06495;text-align:center;margin-top:5px; " width="100%">
					<tr>
						<td width="auto" style="padding:5px;">序号</td>
						<td width="auto" style="padding:5px;">用户账号</td>
						<td width="auto" style="padding:5px;">昵称</td>
						<td width="auto" style="padding:5px;">标题</td>
						<td width="auto" style="padding:5px;">内容</td>
						<td width="auto" style="padding:5px;">创建时间</td>
						<td width="auto" style="padding:5px;">标签</td>
						<td width="auto" style="padding:5px;">操作</td>
					</tr>
					<c:forEach var="content" items="${contentList }" varStatus="status">
						<tr>
							<td style="padding:5px;">${status.index+1 }</td>
							<td style="padding:5px;">${content.user.userName }</td>
							<td style="padding:5px;">${content.user.nickName }</td>
							<td style="padding:5px;">${content.title }</td>
							<td style="padding:5px;">${content.comment }</td>
							<td style="padding:5px;"><fmt:formatDate value="${content.createTime }" pattern="yyy-MM-dd HH:mm"/></td>
							<td style="padding:5px;">${content.nav.nav }</td>
							<td style="padding:5px;"><input style="color:#E06495;border:1px solid #AAAAAA; background: #E6E6E6; font-size:12px; padding:5px;" value="删除" type="button" onclick="deletes('${content.id}')"></td>
						</tr>
					</c:forEach>
				</table>
				
				</article>
				<div align="center">
    		<ul class="pagination">
    			${pageCode}
    		</ul>
    		</div>
		</div>
	</div>
</body>
</html>
