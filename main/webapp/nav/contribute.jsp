<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>投稿</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">

<script type="text/javascript"
	src="${pageContext.request.contextPath }/static/js/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/static/js/utf8-jsp/ueditor.all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCore.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/utf8-jsp/third-party/SyntaxHighlighter/shCoreDefault.css">
	
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<script type="text/javascript" src='${pageContext.request.contextPath }/assets/js/unlock.js'></script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
    SyntaxHighlighter.all();
</script>
	<script type="text/javascript">
		function isMoble(){
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
				return true;
			}else{
				return false;  //转向手机端
			}
		}
	
		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		
		if(${currentUser.userName==18569306303}){
			var ue = UE.getEditor('comment');
		}else{
			var ue = UE.getEditor('comment',{
				readonly:true
			});
		}
		
		/* function aaa() {
			alert(ue.getContent());
		} */
		
		function isSubmit(){
			var title = $('#titles').val();
			var userId = $('#userId').val();
			var userEmail = $('#userEmail').val();
			var conent = ue.getContent();
			$('#commentNoTag').val(ue.getContentTxt());
			if(title==null || title==""){
				$('#error').html("标题不能为空!");
				return false;
			}
			if(userId==null || userId==""){
				$('#error').html("请先登录在投稿!");
				return false;
			}
			if(userEmail==null || userEmail==""){
				$('#error').html("邮箱不能为空!");
				
				return false;
			}
			if(conent==null || conent==""){
				$('#error').html("内容不能为空!");
				return false;
			}
			if(!checkEmail(userEmail)){
				$('#error').html("邮箱格式错误!");
				return false;
			}
			if(isMoble()){
				var lock = $('#lock').html();
				if(lock=='未解锁'){
					$('#error').html("请把解锁划至最右边解锁!");
					return false;
				}
			}
			return true;
		}
		
		function checkEmail(str) {
			var re = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
			if (re.test(str)) {
				return true;
			} else {
				return false;
			}
		}
		
		
	</script>
<style type="text/css">
	.bar {
		margin:10 10 10 0;
		height: 40px;
		width: 300px;
	}
	
</style>
</head>

<body>
	<div id="ctn" style="color:#666666;" >
		<div id="content">
			<form action="${pageContext.request.contextPath}/content/save.do" method="post" onsubmit="return isSubmit()" >

				<article
					class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">
				<hgroup class="post_hctn">
				<div class="post_h_l">
					<h2 class="post_h">
						<a href="#" style="color:#69B5C9;">投稿</a>
					</h2>
				</div>
				</hgroup> 
				
				<p>
					<label style="width: 70px;float: left;">标题</label>
					<input type="text" id="titles" name="title" maxlength="50" class="contributeInput" ${currentUser.userName=='18569306303'?'':'disabled=disabled' }/> <font color="red" style="width:10%;font-size:11px;">*不能超过50字</font>
				</p>
				<p>
					<label style="width: 70px;float: left;">昵称</label>
					<input type="text" id="userId" class="contributeInput" value="${currentUser.id==null?'':currentUser.nickName }" disabled="disabled"/> <font color="red" style="width:10%;font-size:11px;"></font>
					<input type="hidden" name="user.id" value="${currentUser.id}"/>
				</p>
				<p>
					<label style="width: 70px;float: left;">E-mail</label>
					<input type="text" id="userEmail" name="user.email" ${currentUser.userName=='18569306303'?'':'disabled=disabled' } class="contributeInput"/>
				</p>
				<p>
					<label style="width: 70px;float: left;">标签</label>
					<input type="text" id="tag" name="tag" class="contributeInput" ${currentUser.userName=='18569306303'?'':'disabled=disabled' }/>  <font color="red" style="width:10%;font-size:11px;">*标签使用英文逗号隔开,</font>
				</p>
				<p>
					<label style="width: 70px;float: left;">分类</label>
					<select name="nav.id">
						<c:forEach items="${navList }" var="nav">
							<c:if test="${nav.tag==0&&nav.nav!='首页' }">
								<option value="${nav.id }">${nav.nav }</option>
							</c:if>
						</c:forEach>
					</select>
				</p>
				
				<p>
					<label style="width: 70px;float: left;">内容</label> <font color="red" style="width:10%;font-size:11px;">*不能超过300字</font><br/>
					<textarea name="comment" id="comment" style="width: auto; height: 400px;"></textarea> 
					<!-- <textarea rows="10" cols="10">UE.getEditor('editor').getPlainTxt()</textarea> -->
					<input type="hidden" id="commentNoTag" name="commentNoTag"/>
				</p>
				<p>
					<!-- <div class="bar1 bar"></div>
					<div class="bar2 bar"></div> -->
					<div class="bar3 bar"></div>
					<!-- <div class="bar4 bar"></div>
					<div class="bar5 bar"></div> -->
					<font color="red" style="width:10%;font-size:11px;margin-left: 10px;">*滑动最右边解锁  手机不需解锁</font>
				</p>
				
				<p>
					<font color="red" id="error"></font>
					<br/>
					<input type="submit" value="提交" ${currentUser.userName=='18569306303'?'':'disabled=disabled' } style="border:1px solid #AAAAAA; background: #E6E6E6;">
				</p>
				</article>
				
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
		$('.bar1').slideToUnlock();
		$('.bar2').slideToUnlock({
			height : 50,
			width : 200,
		});
		$('.bar3').slideToUnlock({
			height : 40,
			width : 300,
			text : '未解锁',
			succText : '解锁成功'
		});
		$('.bar4').slideToUnlock({
			bgColor : '#fce',
			progressColor : '#f60',
			succColor : '#f00',
			textColor : '#fff',
			succTextColor : '#fff',
		});
</script>
</html>
