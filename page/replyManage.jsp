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
  		function searchLeavingMessage(){
  			$("#dg").datagrid('load',{
  				"reviewcontent":$("#u_reviewcontent").val()
  			});
  		}
		
  		function deleteLeavingMessage(){
  			var selectedRows=$("#dg").datagrid('getSelections');
  			if(selectedRows.length==0){
  				$.messager.alert("系统提示","请选择要删除的评论!");
  				return;
  			}
  			var strIds=[];
  			for(var i =0;i<selectedRows.length;i++){
  				strIds.push(selectedRows[i].id);
  			}
  			var ids=strIds.join(",");
  			$.messager.confirm("系统提示","你确定要删除这<font color='red'>"+selectedRows.length+"</font>这条数据吗?",function(r){
  				if(r){
  					 $.post("${pageContext.request.contextPath}/admin/reply/backstageDelete.do",{ids:ids},function(result){
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
  		function formatterPage(val,row){
  			var page = val.commentPage;
  			if(page.indexOf("title=")!=-1){
  				page = page.substring(page.indexOf("title="));
  				page = page.replace("title=","");
  			} 
  			return page;
  		}
  		function formatterNickName(val,row){
  			return row.leavingMessage.commentNickName;
  		}
  		
  		
  	</script> 
  </head>
  
  <body style="margin:1px">
  <table id="dg" title="回复评论管理" class="easyui-datagrid" fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/admin/reply/backstageList.do" fit="true" toolbar="#tb">
  	<thead>
  		<tr><!-- .commentPage .commentNickName-->
  			<th field="cb" checkbox="true" align="center"></th>
  			<th field="id"  width="50" align="center">编号</th>
  			<th field="leavingMessage"  width="50" align="center" formatter=formatterPage>评论页面</th>
  			<th field="bbb"  width="50" align="center" formatter=formatterNickName>评论人</th>
  			<th field="replyName" width="50" align="center">回复人</th>
  			<th field="comment" width="50" align="center" >回复内容</th>
  			<th field="replyTime" width="50" align="center">回复时间</th>
  		</tr>
  	</thead>
  </table>
  <div id="tb">
  		<div>
			<a href="javascript:deleteLeavingMessage()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
	</div>
	</body>
</html>