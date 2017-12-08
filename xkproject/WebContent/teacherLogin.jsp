<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="jquery-easyui-1.5.3/jquery.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#randImage").click(function(){
				document.getElementById("randImage").src="image.jsp?"+Math.random();
			})
			//验证码输入完成后验证
			$("#imageCode").blur(function(){
				$.post("checkCode.action",{imageCode:$("#imageCode").val()},function(msg){
					if(msg == "OK"){
						$("#msg").text("√");
						$("#msg").css("color","green");
						$("#login").attr("disabled",false);
					}else{
						$("#msg").text("×");
						$("#msg").css("color","red");
						$("#login").attr("disabled",true);
					}
				})
			})
		})
	</script>
</head>
<body style="background:url('images/2.jpg');background-size:cover">
	<div style="float:right; margin-right:50px; margin-top:20px;">
		<a href="index.jsp" style="text-decoration:none;color:black;font-weight:bold;font-size:18px;">返回首页</a>
	</div>
	<div id="dd" class="easyui-dialog" title="教师登录" style="width:500px;height:500px;"   
        data-options="iconCls:'icon-man',resizable:true,modal:true">   
    	<form action="teacherController/teacherLogin.action" method="post">
    		<table style="margin:auto;margin-top:50px;font-size:18px;">
                <tr>
                    <td style="width:80px;height:50px;">姓名：</td>
                    <td><input style="height:20px;" type="text" name="teacher_name"></input></td>
                </tr>
                <tr>
                    <td style="width:80px;height:50px;">密码：</td>
                    <td><input style="height:20px;" style="" type="password" name="teacher_pwd"></input></td>
                </tr>
                <tr>
                    <td style="width:80px;height:50px;">验证码：</td>
                    <td><input style="height:20px;" type="text" name="imageCode" id="imageCode" size="10"/><span id="msg"></span>
    					<img title="换一张试试" name="randImage" id="randImage" src="image.jsp" width="60" height="20" border="1" align="absmiddle">
    				</td>
                </tr>
                <tr>
                	<td colspan="2" align="center" height="50px"><input style="width:50px;height:30px;text-height:6px;font-size:18px;" type="submit" value="登录" id="login"/></td>
                </tr>
            </table>
    	</form>   
	</div> 
</body>
</html>