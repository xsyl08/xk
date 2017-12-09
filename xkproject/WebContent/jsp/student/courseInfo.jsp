<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程信息</title>
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			//定义学期term为全局变量
			var term = null;
			$("#term").combobox({
				onLoadSuccess:function(data){
					$('#term').combobox('select', (data[data.length-1].term_id));
				},
				onSelect:function(data){
					term={
						term_id:data.term_id,
						term_name:data.term_name
					}
					$('#dg').datagrid('load',term);
				}
			})
			//选课提交单击事件
			$("#add_btn").click(function(){
				if($("#dg").datagrid('getSelections').length==0){
					$.messager.alert("消息提示",'请选择要选修的课程','error');
				}else{					
					var rows = $("#dg").datagrid("getSelections");
					var stuToCous = [];
					for(var i=0; i<rows.length; i++){
						console.log(rows[i])
						var stuToCou = [];
						stuToCou.push(rows[i].class_id);
						stuToCou.push(rows[i].class_place);
						stuToCou.push(rows[i].class_weekday);
						stuToCou.push(rows[i].time_id);
						
						stuToCous.push(stuToCou.join(","));
					}
					var cls = stuToCous.join(",");
					$.post("../../studentController/addToMyCourse.action?stuToCous="+cls,term,function(flag){
						if(flag=="OK"){
							$("#dg").datagrid('reload');
							$.messager.alert("消息提示",'选课成功','success');
						}else if(flag=="placeerror"){
							$("#dg").datagrid('reload');
							$.messager.alert("消息提示",'课程地点冲突','error');
						}else if(flag=="timeerror"){
							$("#dg").datagrid('reload');
							$.messager.alert("消息提示",'课程时间冲突','error');
						}
					})
				}
			})
			//课程查询单击事件
			$("#search_btn").click(function(){
				var data = {
					class_name : $("#class_name").val(),
					teacher_name : $("#teacher_name").val(),
					time_detail : $("#time_detail").val(),
					term_id : term.term_id
				}
				console.log(data);
				$('#dg').datagrid('load',data);
			})
			//课程数据重载刷新
			$("#reload_btn").click(function(){
				$('#dg').datagrid('reload');
			})
		})
		function go(value,row,index){
			var c = [];
			c.push(row.class_id);
			c.push(row.class_place);
			c.push(row.class_weekday);
			c.push(row.time_id);
			c.push(row.term_id);
			var data = c.join(",");
			return '<a href="currentStudentOfCourse.jsp?c='+data+'">'+value+'</a>';
		}
		function rest(value,row,index){
			return row.class_capacity-row.currentquantity;
		}
	</script>
</head>
<body>
	<table id="dg" title="课程信息" class="easyui-datagrid" fitColumns="true"
	 pagination="true" rownumbers="true" url="../../courseController/queryAllCourse.action" fit="true"  toolbar="#tb">
		<thead>
			<tr>
				<th data-options="field:'class_id', width:50, align:'center', checkbox:true">课程ID</th>
				<th data-options="field:'class_name', width:100, align:'center'">课程名称</th>
				<th data-options="field:'class_grade', width:100, align:'center'">课程学分</th>
				<th data-options="field:'class_weekday', width:100, align:'center'">星期</th>
				<th data-options="field:'time_detail', width:100, align:'center'">上课时间</th>
				<th data-options="field:'class_place', width:100, align:'center'">上课地点</th>
				<th data-options="field:'teacher_name', width:100, align:'center'">教师名称</th>
				<th data-options="field:'class_capacity', width:100, align:'center'">课程人数</th>
				<th data-options="field:'currentquantity', width:100, align:'center', formatter:go">已选人数</th>
				<th data-options="field:'restquantity', width:100, align:'center', formatter:rest">剩余人数</th>
			</tr>
		</thead>
	</table>
	<div id="tb">
		<div>
			<span>学号：${currentStudent.student_id }</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span>姓名：${currentStudent.student_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<input id="term" class="easyui-combobox" name="term" editable="false"
				data-options="valueField:'term_id',textField:'term_name',panelHeight:'auto',
					url:'../../termController/queryAllTermByStudent.action'" />
		</div>
		<a id="add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add'" plain="true">提交</a>
		<a id="reload_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" plain="true">刷新</a>
		<!-- 条件查询按钮 -->
		<div>
			&nbsp;课程名称：&nbsp;<input type="text" name="class_name" id="class_name" size="10">
			&nbsp;教师名称：&nbsp;<input type="text" name="teacher_name" id="teacher_name" size="10">
			&nbsp;上课时间：&nbsp;<input type="text" name="time_detail" id="time_detail" size="10">
			<a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" plain="true">查询</a>
		</div>		
	</div>
</body>
</html>