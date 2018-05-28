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
  		function searchLink(){
  			$("#dg").datagrid('load',{
  				"nav":$("#u_nav").val()
  			});
  		}
		
  		/**添加的时候值默认为空*/
		function resetValue(){
 			$("#linkName").val("");
			$("#id").val("");
			$("#linkUrl").val("");
			$("#orderNo").val("");
		}
		/**关闭时并将文本框的值设置为空*/
		function closeLink(){
			$("#dlg").dialog("close");
			resetValue();
		}
		/**用于区别修改和添加的路径*/
		var url;
		/**打开用户添加页面*/
		function openLink(){
			$("#dlg").dialog("open").dialog("setTitle","添加标签信息");
			url="${pageContext.request.contextPath}/admin/link/add.do";
		}
		/**添加/修改*/
		function saveLink(){
			$("#fm").form("submit",{
				url:url,
				onSubmit:function(){
					return $(this).form("validate");
				},success:function(result){
					var result = eval('('+result+')');
					if(result.success){
						$.messager.alert("系统提示","保存成功");
						$("#dlg").dialog("close");
						$("#dg").datagrid("reload");
						resetValue();
					}else{
						$.messager.alert("系统提示","保存失败");
						return;
					}
				}
			}); 
		}
		
		/**打开用户修改页面*/
		function openLinkModifyDialog(){
			var selectedRows=$("#dg").datagrid('getSelections');
			if(selectedRows.length!=1){
				$.messager.alert("系统提示","请选择一条要编辑的数据！");
				return;
			}
			$("#dlg").dialog("open").dialog("setTitle","修改标签");
	 		var row=selectedRows[0];
		 	$("#fm").form("load",row);
			url="${pageContext.request.contextPath}/admin/link/add.do";
		}
		
		function deleteLink(){
  			var selectedRows=$("#dg").datagrid('getSelections');
  			if(selectedRows.length==0){
  				$.messager.alert("系统提示","请选择要删除的标签!");
  				return;
  			}
  			var strIds=[];
  			for(var i =0;i<selectedRows.length;i++){
  				strIds.push(selectedRows[i].id);
  			}
  			var ids=strIds.join(",");
  			$.messager.confirm("系统提示","你确定要删除这<font color='red'>"+selectedRows.length+"</font>这条数据吗?",function(r){
  				if(r){
  					 $.post("${pageContext.request.contextPath}/admin/link/backstageDelete.do",{ids:ids},function(result){
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
  	</script> 
  </head>
  
  <body style="margin:1px">
  <table id="dg" title="友情链接管理" class="easyui-datagrid" fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/admin/link/find.do" fit="true" toolbar="#tb">
  	<thead>
  		<tr>
  			<th field="cb" checkbox="true" align="center"></th>
  			<th field="id"  width="50" align="center">编号</th>
  			<th field="linkName"  width="100" align="center">连接名称</th>
  			<th field="linkUrl"  width="100" align="center">连接路径</th>
  			<th field="orderNo" width="100" align="center">排序</th>
  		</tr>
  	</thead>
  </table>
  <div id="tb">
  		<div>
			<a href="javascript:openLink()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openLinkModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteLink()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 650px;height: 300px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		  <form id="fm" method="post">
		  	<table cellspacing="8px;">
		  		<tr>
		  			<td>连接名称：</td>
		  			<td>
		  				<input type="text" name="linkName"  id="linkName" class="easyui-validatebox" required="true" />
		  			</td>
		  		</tr>
		  		<tr>
		  			<td>连接路径：</td>
		  			<td>
		  				<input type="text" name="linkUrl"  id="linkUrl" class="easyui-validatebox" required="true" validType="url" />
		  			</td>
		  		</tr>
		  		<tr>
		  			<td>排序：</td>
		  			<td>
		  				<input type="text" name="orderNo"  id="orderNo" class="easyui-validatebox" required="true" />
		  				<input type="hidden" name="id"  id="id"/>
		  			</td>
		  		</tr>
		  	</table>
		  </form>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:saveLink()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
			<a href="javascript:closeLink()" class="easyui-linkbutton" iconCls="icon-no" >关闭</a>
		</div>
	</body>
</html>