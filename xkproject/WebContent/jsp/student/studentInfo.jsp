<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		var editIndex = undefined;  
		function endEditing() {//该方法用于关闭上一个焦点的editing状态  
		    if (editIndex == undefined) {  
		        return true  
		    }  
		    if ($('#dg').datagrid('validateRow', editIndex)) {  
		        $('#dg').datagrid('endEdit', editIndex);  
		        editIndex = undefined;  
		        return true;  
		    } else {  
		        return false;  
		    }  
		}  
		//点击单元格事件：  
		function onClickCell(index,field,value) {
		    if (endEditing()) {  
		        if(field=="student_pwd"){  
		            $(this).datagrid('beginEdit', index);  
		            var ed = $(this).datagrid('getEditor', {index:index,field:field});  
		            $(ed.target).focus();  
		        }         
		        editIndex = index;  
		    }  
		    $('#dg').datagrid('onClickRow');  
		}  
		//单元格失去焦点执行的方法  
		function onAfterEdit(index, row, changes) {
		    var updated = $('#dg').datagrid('getChanges', 'updated');
		    if (updated.length < 1) {  
		        editRow = undefined;  
		        $('#dg').datagrid('unselectAll');  
		        return;  
		    } else {  
		        // 传值  
		        submitForm(index, row, changes);  
		    }  
		}  
		//提交数据  
		function submitForm(index, row, changes) {
			var student_id = row.student_id;
			var student_pwd = changes.student_pwd;
		    var data = {
		    	"student_id" : student_id,
		    	"student_pwd" : student_pwd
		    }
		    $.post("../../studentController/editStudentInfo.action",data,function(flag){
		    	if(flag == "ok"){
		    		$("#dg").datagrid('reload');
		    	}
		    })
		}
		function edit(){
			$("#dg").datagrid("beginEdit",0);
		}
		//显示入学日期
		$(function(){			
			var c = $("#dg").datagrid("getColumnOption","student_entrydate");
			c.formatter = function go(value,row,index){
				//长整型转为日期
				function dateFormat(longTypeDate){  
				    var dateType = "";  
				    var date = new Date();  
				    date.setTime(longTypeDate); 
				    dateType = date.getFullYear()+"-"+getMonth(date)+"-"+getDay(date);//yyyy-MM-dd格式日期
				    return dateType;
				}
				//返回 01-12 的月份值   
				function getMonth(date){  
				    var month = "";  
				    month = date.getMonth() + 1; //getMonth()得到的月份是0-11  
				    if(month<10){  
				        month = "0" + month;  
				    }  
				    return month;  
				}  
				//返回01-30的日期  
				function getDay(date){  
				    var day = "";  
				    day = date.getDate();  
				    if(day<10){  
				        day = "0" + day;  
				    }  
				    return day;  
				}
				return dateFormat(value);
			}
		})
	</script>
</head>
<body>
	<table id="dg" title="个人信息" class="easyui-datagrid" fitColumns="true" rownumbers="true" fit="true"  toolbar="#tb"
	 data-options="url:'../../studentController/queryStudentInfo.action',onClickCell:onClickCell,
					onAfterEdit:onAfterEdit,singleSelect:true">
		<thead>
			<tr>
				<th field="student_id" width=100>学号</th>
				<th field="student_name" width=100>姓名</th>
				<th field="student_pwd" width=100 editor="text">密码</th>
				<th field="student_sex">性别</th>
				<th field="student_age" width=100>年龄</th>
				<th field="college_name" width=100>学院名称</th>
				<th field="student_entrydate" width=100>入学日期</th>
			</tr>
		</thead>
	</table>
	<div id="tb">
		<a id="edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" plain="true" onclick="edit()">修改</a>
	</div>
</body>
</html>