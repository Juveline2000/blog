<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String mainPage = (String)request.getAttribute("mainPage");
String sendTitle = (String)request.getAttribute("sendTitle");

if(mainPage == null || mainPage.equals("")){
	mainPage = "common/content.jsp";
}
if(sendTitle == null || sendTitle.equals("")){
	sendTitle = "SaikiKuSuo";
}else{
	sendTitle = sendTitle+" | SaikiKuSuo";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%=sendTitle %></title>
	<link rel="icon" href="img/icon6.ico" type="image/x-icon"/>    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
	<script type="text/javascript" src="/js/jquery.js"></script>
	<script type="text/javascript" src="/js/jquery.json.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
	<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/zzsc-demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/assets/less/unlock.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/Style/style.opacity.css">
	<script language="javascript">
	
	/* "img/background-1.jpg","img/background-2.jpg", */
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
			if(system.win||system.mac||system.xll){ //img转向电脑端
				var bgarr = ["${pageContext.request.contextPath }/img/qi.JPG"];
			}else{
				var bgarr = [ "${pageContext.request.contextPath }/img/phone/1.jpg","${pageContext.request.contextPath }/img/phone/2.jpg","${pageContext.request.contextPath }/img/phone/3.jpg","${pageContext.request.contextPath }/img/phone/4.jpg","${pageContext.request.contextPath }/img/phone/5.jpg","${pageContext.request.contextPath }/img/phone/7.jpg","${pageContext.request.contextPath }/img/phone/8.jpg","${pageContext.request.contextPath }/img/phone/9.jpg","${pageContext.request.contextPath }/img/phone/10.jpg","${pageContext.request.contextPath }/img/phone/12.jpg","${pageContext.request.contextPath }/img/phone/13.jpg","${pageContext.request.contextPath }/img/phone/14.jpg","${pageContext.request.contextPath }/img/phone/15.jpg","${pageContext.request.contextPath }/img/phone/16.jpg","${pageContext.request.contextPath }/img/phone/17.jpg","${pageContext.request.contextPath }/img/phone/18.jpg","${pageContext.request.contextPath }/img/phone/19.jpg","${pageContext.request.contextPath }/img/phone/20.jpg" ];
			}
				
	var bgindex = ~~(Math.random() * bgarr.length);
	
</script>

</head>
  
  <body class="home blog" style="background-attachment: fixed!important;">
 <!--  <script>
	document.body.style.backgroundImage="url("+bgarr[bgindex]+")";
	document.body.style.backgroundSize="100%";
	document.body.style.backgroundRepeat="no-repeat";
	document.body.style.backgroundAttachment="fixed";
  </script> -->
  <div id="page">
    <jsp:include page="common/header.jsp" />
    <jsp:include page="common/float.jsp" />
    <jsp:include page="<%=mainPage %>" />
    <jsp:include page="common/link.jsp" />
    <jsp:include page="common/btm.jsp"/>
	<jsp:include page="common/footer.jsp" />
    </div>
  </body>
</html>
