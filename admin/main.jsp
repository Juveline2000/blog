<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(session.getAttribute("currentUser")==null){
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>博客后台管理</title>
<link rel="icon" href="../img/icon6.ico" type="image/x-icon"/>     
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
		
	
		function openTab(text,url,iconCls){
			if($("#tabs").tabs("exists",text)){
				$("#tabs").tabs("select",text);
			}else{
				var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%;' src='${pageContext.request.contextPath}/page/"+url+"'></iframe>";
				$("#tabs").tabs("add",{
					title:text,
					iconCls:iconCls,
					closable:true,
					content:content
				});
			}
		}
		/**用于区别修改和添加的路径*/
		var url;
		/**添加/修改*/
		function saveUser(){
			$("#fm").form("submit",{
				url:url,
				onSubmit:function(){
					return $(this).form("validate");
				},
				success:function(result){
					var result = eval('('+result+')');
					if(result.success){
						$.messager.alert("系统提示","修改成功");
						resetValue();
						$("#dlg").dialog("close");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","保存失败");
						return;
					}
				}
			});
		}
		function resetValue(){
			$("#password").val("");
			$("#password3").val("");
		}
		/**关闭时并将文本框的值设置为空*/
		function closeUserDialog(){
			$("#dlg").dialog("close");
			resetValue();
		}
		/**打开用户修改页面*/
		function openUserModifyDialog(){
			$("#dlg").dialog("open").dialog("setTitle","编辑用户信息");
			url="${pageContext.request.contextPath }/admin/user/update.do";
		}
		
		function loginOut(){
			$.messager.confirm("系统提示","是否要退出登录",function(r){
  				if(r){
  					window.location.href = "${pageContext.request.contextPath }/user/loginOut.do";
  				}
  			});
		}
		
		function refurbishSys(){
			window.location.href = "${pageContext.request.contextPath }/admin/refurbish/refurbishSys.do";
			alert("刷新成功!");
		}
	</script>
  </head>
  <body class="easyui-layout">
  	<div region="north" style="height:78px;background-color:#E0ECFF;">
  		<table style="padding:3px; width:100%;">
  			<tr>
  				<td width="50%">
  					<img src="${pageContext.request.contextPath}/img/logo3.png" />
  				</td>
  				<td valign="bottom" align="right" width="50%">
  					<iframe allowtransparency="true" frameborder="0" width="410" height="64" scrolling="no" src="//tianqi.2345.com/plugin/widget/index.htm?s=2&z=3&t=1&v=2&d=2&bd=0&k=&f=&ltf=009944&htf=cc0000&q=0&e=1&a=1&c=54511&w=410&h=64&align=center"></iframe>
  				</td>
  			</tr>
  		</table>
  	</div>
  	<div region="center">
  		<div class="easyui-tabs" fit="true" border="false" id="tabs">
  			<div title="首页" data-options="iconCls:'icon-home'">
  				<div align="center" style="padding-top:100px"><font color="red" size="10">欢迎使用</font></div>
  			</div>
  		</div>
  	</div>
  	<div region="west" style="width:200px;" title="导航菜单" split="true">
  		<div class="easyui-accordion" data-options="fit:true,border:false">
  			<div title="用户管理" data-options="selected:true,iconCls:'icon-grxx'" style="padding:10;">
  				<a href="javascript:openTab('用户管理','userManage.jsp','icon-grxx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxx'" style="width:150px;">用户管理</a>
  			</div>
  			<div title="导航栏管理" data-options="selected:true,iconCls:'icon-bklb'" style="padding:10;">
  				<a href="javascript:openTab('导航栏管理','navManage.jsp','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width:150px;">导航栏管理</a>
  			</div>
  			<div title="投稿管理" data-options="selected:true,iconCls:'icon-writeblog'" style="padding:10;">
  				<a href="javascript:openTab('投稿管理','contributeManage.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width:150px;">投稿管理</a>
  			</div>
  			<div title="评论管理" data-options="selected:true,iconCls:'icon-fwgd'" style="padding:10;">
  				<a href="javascript:openTab('评论管理','commentManage.jsp','icon-fwgd')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwgd'" style="width:150px;">评论管理</a>
  				<a href="javascript:openTab('回复评论管理','replyManage.jsp','icon-sjzdgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-sjzdgl'" style="width:150px;">回复评论管理</a>
  			</div>
  			
  			<div title="系统管理" data-options="iconCls:'icon-system'" style="padding:10px;">
  				<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" 
  				data-options="plain:true,iconCls:'icon-modifyPassword'" style="width:150px;">修改密码</a>
  				<a href="javascript:openTab('友情链接管理','linkManage.jsp','icon-bkgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bkgl'" style="width:150px;">友情链接管理</a>
  				<a href="javascript:refurbishSys()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" 
  				style="width:150px;">刷新系统缓存</a>
  				<a href="javascript:loginOut()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" 
  				style="width:150px;">安全退出</a>
  			</div>
  		</div>
  	</div>
  	<div id="dlg" class="easyui-dialog" style="width: 650px;height: 300px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		  <form id="fm" method="post">
		  	<table cellspacing="8px;">
		  		<tr>
		  			<td>修改密码:</td>
		  			<td><input type="text" id="password3" name="password" class="easyui-validatebox" required="true"/></td>
		  			<td><input type="hidden" id="ids" name="id" value="${currentUser.id }" /></td>
		  		</tr>
		  	</table>
		  </form>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
			<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-no" >关闭</a>
		</div>
  </body>
</html>
