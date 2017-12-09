<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TH大学选课系统登录</title>
	<link rel="stylesheet" type="text/css" href="insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#randImage").click(function(){//单击验证码刷新
				document.getElementById("randImage").src="image.jsp?"+Math.random();
			})
			$("#imageCode").blur(function(){//验证码输入完成后验证，验证码错误登录按钮不可用
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
			$("#imageCode").focus(function(){//验证码框获得焦点时，登录按钮可用
				$("#login").attr("disabled",false);
			})
		})
	</script>
</head>
<body style="background:url('images/2.jpg');background-size:cover">
	<div id="dd" class="easyui-dialog" title="用户登录" style="width:500px;height:500px;" closable="false" 
        data-options="iconCls:'icon-man',resizable:true,modal:true">
        <div style="width:100%;height:100%;background:url('images/back.jpg');">
	    	<form action="teacherController/userLogin.action" method="post">
	    		<table style="margin:auto;font-size:18px;">
	    			<tr>
	    				<td colspan="2" align="center" height="50px"></td>
	    			</tr>
	                <tr>
	                    <td style="width:80px;height:50px;">姓名：</td>
	                    <td><input style="height:20px;" type="text" name="user_name" value="${user_name}"></input></td>
	                </tr>
	                <tr>
	                    <td style="width:80px;height:50px;">密码：</td>
	                    <td><input style="height:20px;" type="password" name="user_pwd" value="${user_pwd}"></input></td>
	                </tr>
	                <tr>
	                    <td style="width:80px;height:50px;">验证码：</td>
	                    <td><input style="height:20px;" type="text" name="imageCode" id="imageCode" size="10"/><span id="msg"></span>
	    					<img title="换一张试试" name="randImage" id="randImage" src="image.jsp" width="60" height="20" border="1" align="absmiddle">
	    				</td>
	                </tr>
	                <tr>
	                	<td colspan="2" align="center" height="50px">
	                		<label for="user_student">学生</label>
	                		<input type="radio" name="user_type" id="user_student" value="学生">&nbsp;&nbsp;&nbsp;&nbsp;
	                		<label for="user_teacher">教师</label>
	                		<input type="radio" name="user_type" id="user_teacher" value="教师">
	                	</td>
	                </tr>
	                <tr>
	                	<td colspan="2" align="center" height="50px"><input style="width:50px;height:30px;text-height:6px;font-size:18px;" type="submit" value="登录" id="login"/></td>
	                </tr>
	                <tr>
	                	<td colspan="2" align="center" height="50px">
	                		<span style="color:red">${msg}</span>
	                	</td>
	                </tr>
	            </table>    		
	    	</form>
    	</div>
	</div> 
</body>
</html>