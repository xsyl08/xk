<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生个人成绩</title>
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#reload_btn").click(function(){
				$("#dg").datagrid('reload');
			})
			$("#term").combobox({
				onLoadSuccess:function(data){
					$('#term').combobox('select', (data[data.length-1].term_id));
				},
				onSelect:function(data){
					var term={
						term_id:data.term_id,
						term_name:data.term_name
					}
					$('#dg').datagrid('load',term);
				}
			})
		})
	</script>
</head>
<body>
	<table id="dg" title="个人成绩" class="easyui-datagrid" fitColumns="true"
	 pagination="true" rownumbers="true" url="../../studentController/queryScoreByStudent.action" fit="true"  toolbar="#tb">
		<thead>
			<tr>
				<th field="class_id" width="50" align="center">课程编号</th>
				<th field="class_name" width="100" align="center">课程名称</th>
				<th field="class_score" width="100"  align="center">课程成绩</th>
				<th field="score_point" width="100"  align="center">绩点</th>
				<th field="score_level" width="100"  align="center">是否通过</th>
				<th field="getgrade" width="100"  align="center">获得学分</th>
			</tr>
		</thead>
	</table>
	<div id="tb">
		<span>学号：${currentStudent.student_id }</span>&nbsp;&nbsp;&nbsp;&nbsp;
		<span>姓名：${currentStudent.student_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
		<input id="term" class="easyui-combobox" name="term" editable="false"
			data-options="valueField:'term_id',textField:'term_name',panelHeight:'auto',
				url:'../../termController/queryAllTermByStudent.action'" />&nbsp;&nbsp;
		<a id="reload_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" plain="true">刷新</a>
	</div>
</body>
</html>