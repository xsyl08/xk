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
		        if(field=="teacher_pwd"){  
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
			var teacher_id = row.teacher_id;
			var teacher_pwd = changes.teacher_pwd;
		    var data = {
		    	"teacher_id" : teacher_id,
		    	"teacher_pwd" : teacher_pwd
		    }
		    $.post("../../teacherController/editTeacherInfo.action",data,function(flag){
		    	if(flag == "ok"){
		    		$("#dg").datagrid('reload');
		    	}
		    })
		}
		function edit(){
			$("#dg").datagrid("beginEdit",0);
		}
		function undo(){
			editRow = undefined;
			$("#dg").datagrid("rejectChanges");
			$("#dg").datagrid("unselectAll");
		}
		function save(){
			$("#dg").datagrid("endEdit",0);
		}
	</script>
</head>
<body>
	<table id="dg" title="个人信息" class="easyui-datagrid" fitColumns="true" pagination="false" rownumbers="true" 
	 data-options="url:'../../teacherController/queryTeacherInfo.action',
					onClickCell:onClickCell,
					onAfterEdit:onAfterEdit,
					singleSelect:true"
	 fit="true"  toolbar="#tb">
		<thead>
			<tr>
				<th field="teacher_id" width=100>教师编号</th>
				<th field="teacher_name" width=100>姓名</th>
				<th field="teacher_pwd" width=100 editor="text">密码</th>
				<th field="college_name" width=100>学院名称</th>
			</tr>
		</thead>
	</table>
	<div id="tb">
		<a id="edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" plain="true" onclick="edit()">修改</a>
		<a id="undo_btn" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" plain="true" onclick="undo()">撤销</a>
		<a id="save_btn" class="easyui-linkbutton" data-options="iconCls:'icon-save'" plain="true" onclick="save()">保存</a>
	</div>
</body>
</html>