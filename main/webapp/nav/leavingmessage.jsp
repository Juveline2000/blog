<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>  
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

<title>My JSP 'contribute.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<!--  <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
 <script  type="text/javascript" src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
 <script  type="text/javascript" src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
 -->
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/normalizePhone.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/jquery.slideunlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.mobile.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.slideunlock.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src='${pageContext.request.contextPath }/assets/js/unlock.js'></script>
<style type="text/css">
	.bar {
		margin:10 10 10 0;
		height: 40px;
		width: 300px;
	}
</style>
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
	function isSubmit(){
		var reviewcontent=$('#reviewcontent').val();
		var commentNickName=$('#commentNickName').val();
		var commentEmail=$('#commentEmail').val();
		if(reviewcontent == null || reviewcontent==''){
			$('#error').html("内容不能为空");
			return false;
		}
		var  reg = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
		if(reviewcontent.replace(reg,"")==""){
			$('#error').html("内容不能有script语言");
			return false;
		}
		
		if(commentNickName == null || commentNickName==''){
			$('#error').html("昵称不能为空");
			return false;
		}
		if(commentEmail == null || commentEmail==''){
			$('#error').html("邮箱不能为空");
			return false;
		}
		if(!checkEmail(commentEmail)){
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
	function reply(id,replyName){
		$('#replyName').show();
		$('#replyName').html("回复给:<font color='#D60883' size='5px'>"+replyName+"</font>&nbsp;&nbsp;&nbsp;&nbsp;<button  style='border:1px solid #AAAAAA; background: #E6E6E6;' onclick='revoke()'>撤销回复</button>");
		document.getElementById("form").action="${pageContext.request.contextPath }/leavingMessage/replysave.do";
		$('#commentId').val(id);
	}
	function revoke(){
		$('#replyName').html("");
		document.getElementById("form").action="${pageContext.request.contextPath }/leavingMessage/save.do";
		$('#commentId').val("");
	}
</script>
</head>

<body>
			<article
				class=" post-3994 post type-post status-publish format-standard hentry category-software tag-windows tag-1005">
			<hgroup class="post_hctn">
			<div class="post_h_l">
				<h2 class="post_h" style="color:#69B5C9;">
					留言
				</h2>
			</div>
			</hgroup>
			<p id="replyName"></p>
			<form id="form" action="${pageContext.request.contextPath }/leavingMessage/save.do" method="post" onsubmit="return isSubmit()">
				<div style="width:80%;"><textarea rows="10%" style="border:1px solid #B3B3B3; width:100%; color:#5E5E5E;" id="reviewcontent" name="reviewcontent"></textarea></div>
				<br/>
				<input type="text" name="commentNickName" placeholder="昵称" id="commentNickName" style="border:1px solid #B3B3B3; color:#5E5E5E;background-color: #E6E6E6; margin:0 60 10 0;width:260px;"/>
				<input type="text" name="commentEmail" placeholder="邮箱" id="commentEmail" style="border:1px solid #B3B3B3; color:#5E5E5E;background-color: #E6E6E6;width:260px; margin:0 60 10 0;"/>
				<input type="hidden" name="commentId" id="commentId"/>
				<p>
					<!-- <div class="bar1 bar"></div>
					<div class="bar2 bar"></div> -->
					<div class="bar3 bar"></div>
					<!-- <div class="bar4 bar"></div>
					<div class="bar5 bar"></div> -->
					<font color="red" style="width:10%;font-size:11px;margin-left: 10px;">*滑动最右边解锁  手机不需解锁</font>
				</p>
				<font id="error" color="red"></font>
				<br/><input type="submit" value="提交" style="border:1px solid #AAAAAA; background: #E6E6E6;">
			</form>
			<br/>
			<c:set var="startIndex" value="${fn:length(leavingMessagesList) }"></c:set>
		<script type="text/javascript">
			function show(lenght){
				for(var i = 0;i<5;i++){
					var len = lenght-i;
					$("#cmt"+len+"").show();
				}
				$("#showAndHide").html("<a onclick='hide("+lenght+")' style='color:#fff;cursor: pointer!important;'>隐藏评论</a>");
			}
			
			function hide(lenght){
				for(var i = lenght+1;i>6;i--){
					var len = i-1;
					$("#cmt"+len+"").hide();
				}
				$("#showAndHide").html("<a onclick='show("+lenght+")' style='color:#fff;cursor: pointer!important;'>显示全部评论</a>");
			}
		</script>
			<c:if test="${startIndex>5 }">
			<div style="width:100%;height:50px;"><div style="float:left;padding:10px;background-color:#69B5C9;cursor: pointer!important;" id="showAndHide">
			<a onclick="show('${startIndex}')" style='color:#fff;cursor: pointer!important;'>显示全部评论</a></div></div>
			</c:if>
	<c:forEach items="${leavingMessagesList }" var="leavingMessages" varStatus="status">
			<div id="cmt${startIndex-status.index}" class="cmt">
				<ol class="cmt_list">
					<li class="comment even thread-even depth-1" id="li-comment-7332">
						<p>${startIndex-status.index}楼</p>
						<article id="comment-7332" class="comment"> <header
							class="comment-meta comment-author vcard"> <img
							src="${pageContext.request.contextPath }/img/1.jpg"
							class="avatar avatar-88" height="88" width="88">
						<div class="cmt_meta_head">
							<cite class="fn">${leavingMessages.commentNickName } </cite>
						</div>
						<span class="cmt_meta_time"><fmt:formatDate value="${leavingMessages.commentTime }" pattern="yyy-MM-dd HH:mm"/></span>
						</header> <section
							class="comment-content comment">
						<p>${leavingMessages.reviewcontent }</p>
						<input rel='nofollow' class='comment-reply-link' type="button" onclick="reply('${leavingMessages.id }','${leavingMessages.commentNickName }')" value="回复"/></section> </article>
						<c:forEach items="${leavingMessages.replyList }" var="reply">
						<ol class="children">
							<li
								class="comment byuser comment-author-saber bypostauthor odd alt depth-2"
								id="li-comment-7334"><article id="comment-7334"
									class="comment"> <header
									class="comment-meta comment-author vcard"> <img
									src="${pageContext.request.contextPath }/img/1.jpg"
									class="avatar avatar-88" height="88" width="88">
								<div class="cmt_meta_head">
									<cite class="fn">${reply.replyName }<!-- <span class="cmt_meta_auth">
											文章作者</span> -->
									</cite>
								</div>
								<span class="cmt_meta_time"><fmt:formatDate value="${reply.replyTime }" pattern="yyy-MM-dd HH:mm"/></span>
								</header> <section
									class="comment-content comment">
								<p>${reply.comment }</p>
								</section> </article></li>
							<!-- #comment-## -->
						</ol>
						</c:forEach>
						<!-- .children -->
					</li>
					<!-- #comment-## -->
				</ol>
			</div>
		<script type="text/javascript">
			if('${startIndex-status.index}'>5){
				$("#cmt"+'${startIndex-status.index}'+"").hide();
			}
		</script>
</c:forEach>

			</article>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src='${pageContext.request.contextPath }/assets/js/unlock.js'></script>
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
