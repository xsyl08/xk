<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师个人课程</title>
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var editRow = undefined; //定义全局变量：当前编辑的行
	        var dg = $("#dg").datagrid({
	            url: '../../teacherController/queryCourseByTeacher.action', //请求的数据源
	            iconCls: 'icon-save', //图标
	            pagination: true, //显示分页
	            pageSize: 10, //页大小
	            pageList: [5, 10, 15, 20], //页大小下拉选项此项各value是pageSize的倍数
	            fit: true, //datagrid自适应宽度
	            fitColumn: false, //列自适应宽度
	            striped: true, //行背景交换
	            nowap: true, //列内容多时自动折至第二行
	            border: false,
	            idField: 'cd', //主键
	            columns: [[//显示的列
	                {field:'cd',title:'编号',width:100,checkbox:true},
	                {field:'class_id',title:'课程编号',width: 100, sortable: true,editor:'text'},
	                {field:'class_name',title:'课程名称',width: 100,editor:'text'},
	                {field:'class_grade',title:'课程学分',width: 100,editor:'text'},
	                {field:'class_place',title:'上课地点',width: 100,editor:'text'},
	                {field:'class_weekday',title:'星期',width: 100,editor:'text'},
	                {field:'time_detail',title:'上课时间',width: 100,
	                	editor:{
	                		type:'combobox',
	                		options:{
	                			valueField:'time_id',
	                			textField:'time_detail',
	                			url:'../../timeInfoController/queryAllTimeInfo.action'
	                		}
	                	}
	                },
	                {field:'class_capacity',title:'课程人数',width: 100,editor:'text'},
	                {field:'currentquantity',title:'已选人数',width: 100,
	                	formatter:function(value,row,index){
	                		var c = [];
	        				c.push(row.class_id);
	        				c.push(row.class_place);
	        				c.push(row.class_weekday);
	        				c.push(row.time_id);
	        				c.push(row.term_id);
	        				var data = c.join(",");
	        				return '<a href="currentStudentOfCourse.jsp?c='+data+'">'+value+'</a>';
	                	}},
	                {field: 'restquantity', title: '剩余人数', width: 100,
	                	formatter:function(value,row,index){
	                		return row.class_capacity-row.currentquantity;
	                	}}
	            ]],
				//添加列表的操作按钮添加，修改，删除等
	            toolbar: [{ text: '添加', 
	            	iconCls: 'icon-add', 
	            	handler: function () {
	            		//添加时先判断是否有开启编辑的行，如果有则把开启编辑的那行结束编辑
	                    if (editRow != undefined) {
	                        dg.datagrid("endEdit", editRow);
	                    }
	                    //添加时如果没有正在编辑的行，则在datagrid的第一行插入一行
	                    if (editRow == undefined) {
	                        dg.datagrid("insertRow", {
	                            index: 0, // index start with 0
	                            row: {}
	                        });
	                        //将新插入的那一行开户编辑状态
	                        dg.datagrid("beginEdit", 0);
	                        //给当前编辑的行赋值
	                        editRow = 0;
	                     }
	                }}, '-',{ text: '删除', 
	                iconCls: 'icon-remove', 
	                handler: function () {
	                     //删除时先获取选择行
	                     var rows = dg.datagrid("getSelections");
	                     //选择要删除的行
	                     if (rows.length > 0) {
	                         $.messager.confirm("提示", "你确定要删除吗?", function (r) {
	                             if (r) {
	                                 var ids = [];
	                                 for (var i = 0; i < rows.length; i++) {
	                                     ids.push(rows[i].class_id);
	                                 }
	                                 alert(ids.join(','));
	                             }
	                         });
	                     }
	                     else {
	                         $.messager.alert("提示", "请选择要删除的行", "error");
	                     }
	                 }}, '-',{ text: '修改',
					 iconCls: 'icon-edit',
	                 handler: function () {
	                     //修改时要获取选择到的行
	                     var rows = dg.datagrid("getSelections");
	                     //如果只选择了一行则可以进行修改，否则不操作
	                     if (rows.length == 1) {
	                         //修改之前先关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件
	                         if (editRow != undefined) {
	                             dg.datagrid("endEdit", editRow);
	                         }
	                         //当无编辑行时
	                         if (editRow == undefined) {
	                             //获取到当前选择行的下标
	                             var index = dg.datagrid("getRowIndex", rows[0]);
	                             //开启编辑
	                             dg.datagrid("beginEdit", index);
	                             //把当前开启编辑的行赋值给全局变量editRow
	                             editRow = index;
	                             //当开启了当前选择行的编辑状态之后，
	                             //应该取消当前列表的所有选择行，要不然双击之后无法再选择其他行进行编辑
	                             dg.datagrid("unselectAll");
	                         }
	                     }
	                 }}, '-',{ text: '保存',
	                 iconCls: 'icon-save', 
	                 handler: function () {
	                     //保存时结束当前编辑的行，自动触发onAfterEdit事件如果要与后台交互可将数据通过Ajax提交后台
	                     dg.datagrid("endEdit", editRow);
	                 }}, '-',{ text: '取消编辑', 
	                 iconCls: 'icon-redo', 
	                 handler: function () {
	                     //取消当前编辑行把当前编辑行罢undefined回滚改变的数据,取消选择的行
	                     editRow = undefined;
	                     dg.datagrid("rejectChanges");
	                     dg.datagrid("unselectAll");
	                 }}, '-'],
	            onAfterEdit: function (rowIndex, rowData, changes) {
                    //endEdit该方法触发此事件
                    console.info(rowData);
                    console.log(changes);
                    $.post("../../teacherController/addOrModifyCourse.action",rowData,function(flag){
                    	alert(flag)
                    })
                    editRow = undefined;
	            },
	            onDblClickRow: function (rowIndex, rowData) {
	                //双击开启编辑行
                    if (editRow != undefined) {
                        dg.datagrid("endEdit", editRow);
                    }
                    if (editRow == undefined) {
                        dg.datagrid("beginEdit", rowIndex);
                        editRow = rowIndex;
                    }
                }
	    	});
		})
	</script>
</head>
<body>
	<table id="dg"></table>
</body>
</html>