<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="../insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="../insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="../insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="../insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="../insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var treeData = [{
				text : "学生选课系统",
				iconCls : "icon-menu",
				children : [ {
					text : "个人信息",
					iconCls : "icon-man",
					attributes : {
						url : "studentInfo.jsp"
					}
				}, {
					text : "课程信息",
					iconCls : "icon-sum",
					attributes : {
						url : "courseInfo.jsp"
					}
				},{
					text : "个人课表",
					iconCls : "icon-set",
					attributes : {
						url : "myCourse.jsp"
					}
				},{
					text : "成绩查询",
					iconCls : "icon-search",
					attributes : {
						url : "myScore.jsp"
					}
				} ]
			} ]
			//菜单栏中去添加树状结构
			$("#tree").tree({
				data : treeData,
				lines:true,//定义是否显示树线.
				onClick : function(node){//通过点击节点 打开选项卡
					 if(node.attributes){//如果节点有attributes属性
						openTab(node.text,node.attributes.url,node.iconCls);
					} 	 
				}
			})
			//新增选项卡
			function openTab(text,url,iconCls){
				if($("#tabs").tabs("exists",text)){//如果选项卡存在现实当前的选项卡
					$("#tabs").tabs("select",text);
				}else{
					var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src=<%=request.getContextPath()%>/jsp/student/"+url+"></iframe>";
					$("#tabs").tabs('add',{
						title:text,
						closable:true,
						content:content,
						iconCls:iconCls,
					});
				}
			}
		})
	</script>
</head>
<body class="easyui-layout" style="background:url('<%=request.getContextPath()%>/images/2.jpg');background-size:cover">
	<div data-options="region:'north',border:false"	style="height: 60px; background: #B3DFDA; padding: 10px">
		<div style="float:right;margin-top:15px;margin-right:50px">
			<span>学号：${currentStudent.student_id }</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>姓名：${currentStudent.student_name}</span>
			<a href="../studentController/studentLogout.action"	style="margin-left: 20px; text-decoration: none;">注销</a>
    	</div>
	</div>
	<div data-options="region:'west',split:false,title:'导航菜单'" style="width: 150px; padding: 10px;">
		<ul id="tree"></ul>
	</div>
	<div data-options="region:'south',border:false"	style="height: 50px; background: #A9FACD; padding: 10px;">
		<p align="center">版权所有&copy;www.thu.com</p>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-tabs" fit="true" id="tabs">
			<div title="首页" align="center" style="padding-top: 100px">
				<font color="red" size="10">欢迎光临TH大学选课系统</font>
			</div>
		</div>
	</div>
</body>
</html>