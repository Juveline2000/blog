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
	<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/utf8-jsp/ueditor.all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCore.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCoreDefault.css">
	<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	
  	 <script type="text/javascript">
    SyntaxHighlighter.all();
  	 	//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		var ue = UE.getEditor('comment');
		/**回车搜索/按钮搜索*/
  		function searchContribute(){
  			$("#dg").datagrid('load',{
  				"nav.nav":$("#u_nickName").val(),
  				"tag":$("#u_tag").val(),
  				"title":$("#u_title").val(),
  				"comment":$("#u_comment").val()
  			});
  		}
		
  		function deleteUser(){
  			var selectedRows=$("#dg").datagrid('getSelections');
  			if(selectedRows.length==0){
  				$.messager.alert("系统提示","请选择要删除的投稿!");
  				return;
  			}
  			var strIds=[];
  			for(var i =0;i<selectedRows.length;i++){
  				strIds.push(selectedRows[i].id);
  			}
  			var ids=strIds.join(",");
  			$.messager.confirm("系统提示","你确定要删除这<font color='red'>"+selectedRows.length+"</font>这条数据吗?",function(r){
  				if(r){
  					 $.post("${pageContext.request.contextPath}/admin/content/backstageDelete.do",{ids:ids},function(result){
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
  		function formatterUser(val,row){
  			return val.nickName;
  		}
  		function formatterNav(val,row){
  			return val.nav;
  		}
  		function formatterComment(val,row){
  			if (row.comment.indexOf("<hr/>")!=-1) {
  			return row.comment.substring(0, row.comment.indexOf("<hr/>"));
  			}
  			return row.comment;
  		}
  		
  		
  		/**用于区别修改和添加的路径*/
		var url;
		function saveContribute(){
			$("#fm").form("submit",{
				url:url,
				onSubmit:function(){
					$('#commentNoTag').val(ue.getContentTxt());
					return $(this).form("validate");
				},success:function(result){
					var result = eval('('+result+')');
					if(result.success){
						$.messager.alert("系统提示","保存成功");
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
		/**添加的时候值默认为空*/
		function resetValue(){
			$("#titles").val("");
			$("#tag").val("");
			UE.getEditor('comment').setContent("");
		}
		/**关闭时并将文本框的值设置为空*/
		function closeContributeDialog(){
			$("#dlg").dialog("close");
			resetValue();
		}
		/**打开用户修改页面*/
		function openContributeModifyDialog(){
			var selectedRows=$("#dg").datagrid('getSelections');
			if(selectedRows.length!=1){
				$.messager.alert("系统提示","请选择一条要编辑的数据！");
				return;
			}
			$("#dlg").dialog("open").dialog("setTitle","修改投稿");
	 		var row=selectedRows[0];
		 	$("#fm").form("load",row);
		 	UE.getEditor('comment').setContent(row.comment);
			url="${pageContext.request.contextPath}/admin/content/backstageUpdate.do";
		}
		
		function formatterTitle(val,row){
			return "<a target='_blank' href='${pageContext.request.contextPath}/details/"+val+".html'>"+val+"</a>";
		}
  	</script> 
  </head>
  
  <body style="margin:1px">
  <table id="dg" title="投稿管理" class="easyui-datagrid" fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/admin/content/backstageList.do" fit="true" toolbar="#tb">
  	<thead>
  		<tr>
  			<th field="cb" checkbox="true" align="center"></th>
  			<th field="id"  width="50" align="center">编号</th>
  			<th field="user"  width="50" align="center" formatter=formatterUser>投稿用户</th>
  			<th field="title" width="100" align="center" formatter=formatterTitle>标题</th>
  			<th field="comment"  width="250" hidden="true" align="center">评论内容</th>
  			<th field="comment2"  width="250" align="center" formatter=formatterComment>评论内容</th>
  			<th field="createTime" width="70" align="center">评论时间</th>
  			<th field="nav" width="100" align="center"formatter=formatterNav>标签</th>
  			<th field="tag" width="100" align="center">关键词</th>
  			<th field="clickHit" width="50" align="center">点击访问</th>
  		</tr>
  	</thead>
  </table>
  <div id="tb">
  		<div>
			<a href="javascript:openContributeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;标题:&nbsp;<input type="text" name="title"  id="u_title"  size="20" onkeydown="if(event.keyCode==13) searchContribute()"/>
			&nbsp;内容：&nbsp;<input type="text" size="20" id="u_comment" name="comment" onkeydown="if(event.keyCode==13) searchContribute()"/>
			&nbsp;关键词:&nbsp;<input type="text" name="tag"  id="u_tag"  size="20" onkeydown="if(event.keyCode==13) searchContribute()"/>
			
			<a href="javascript:searchContribute()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 670px;height: 500px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		  <form id="fm" method="post">
		  	<table cellspacing="8px;">
		  		<tr>
					<td><label style="width: 70px;float: left;">标题</label>
					<input type="hidden" id="id" name="id"  class="contributeInput"/>
					<input type="hidden" id="commentNoTag" name="commentNoTag"/>
					<input type="text" id="titles" name="title" maxlength="50" class="contributeInput"/> <font color="red" style="width:10%;font-size:11px;">*不能超过50字</font></td>
				</tr>
				<tr>
					<td><label style="width: 70px;float: left;">标签</label>
					<input type="text" id="tag" name="tag" class="contributeInput"/> <font color="red" style="width:10%;font-size:11px;">*标签使用英文逗号隔开,</font></td>
				</tr>
				<tr>
					<td><label style="width: 70px;float: left;">分类</label>
					<select name="nav.id">
						<c:forEach items="${navList }" var="nav">
							<c:if test="${nav.tag==0&&nav.nav!='首页' }">
								<option value="${nav.id }">${nav.nav }</option>
							</c:if>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>
					<!-- 加载编辑器的容器 -->
					<label style="width: 70px;float: left;">内容</label> <font color="red" style="width:10%;font-size:11px;">*不能超过300字</font><br/>
					<textarea name="comment" id="comment" style="width: auto; height: 400px;"></textarea> </td>
				</tr>
		  	</table>
		  </form>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:saveContribute()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
			<a href="javascript:closeContributeDialog()" class="easyui-linkbutton" iconCls="icon-no" >关闭</a>
		</div>
	</body>
</html>