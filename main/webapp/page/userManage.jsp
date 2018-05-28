<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userManage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
  	 <script type="text/javascript">
		/**回车搜索/按钮搜索*/
  		function searchUser(){
  			$("#dg").datagrid('load',{
  				"userName":$("#u_userName").val(),
  				"nickName":$("#u_nickName").val()
  			});
  		}
		
  		function deleteUser(){
  			var selectedRows=$("#dg").datagrid('getSelections');
  			if(selectedRows.length==0){
  				$.messager.alert("系统提示","请选择要删除的用户!");
  				return;
  			}
  			var strIds=[];
  			for(var i =0;i<selectedRows.length;i++){
  				strIds.push(selectedRows[i].id);
  			}
  			var ids=strIds.join(",");
  			$.messager.confirm("系统提示","你确定要删除这<font color='red'>"+selectedRows.length+"</font>这条数据吗?",function(r){
  				if(r){
  					 $.post("${pageContext.request.contextPath}/admin/user/backstageDelete.do",{ids:ids},function(result){
  						if(result.success){
  							$.messager.alert("系统提示","数据已成功删除!");
  							$("#dg").datagrid("reload");
  						}else{
							$.messager.alert("系统提示","数据失败删除!");  						
  						}
  					},"json"); 
  				}
  			});
  		}
  		function formatterSex(val,row){
  			return val==1?'男':'女';
  		}
  		
  		function formatterHeadPortrait(val,row){
  			return "<img src='${pageContext.request.contextPath}/img/"+val+"' style='width:50px;height:50px;'/>";
  		}
  	</script> 
  </head>
  
  <body style="margin:1px">
  <table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/admin/user/backstageList.do" fit="true" toolbar="#tb">
  	<thead>
  		<tr>
  			<th field="cb" checkbox="true" align="center"></th>
  			<th field="id"  width="50" align="center">编号</th>
  			<th field="userName"  width="100" align="center">账号</th>
  			<th field="password"  width="150" align="center">密码</th>
  			<th field="nickName" width="100" align="center">昵称</th>
  			<th field="email" width="100" align="center">Email</th>
  			<th field="sex" width="100" align="center" formatter="formatterSex">性别</th>
  			<th field="phone" width="100" align="center">手机</th>
  			<th field="headPortrait" width="100" align="center" formatter="formatterHeadPortrait">头像</th>
  			<th field="details" width="100" align="center">详情</th>
  		</tr>
  	</thead>
  </table>
  <div id="tb">
  		<div>
			<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;账号：&nbsp;
			<input type="text" size="20" id="u_userName" name="userName" onkeydown="if(event.keyCode==13) searchUser()"/>
			&nbsp;昵称:&nbsp;<input type="text" name="nickName"  id="u_nickName"  size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
			<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	</body>
</html>