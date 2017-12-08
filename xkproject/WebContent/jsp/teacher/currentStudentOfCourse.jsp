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
		$(function(){
			function dateFormat(longTypeDate){  
			    var dateType = "";  
			    var date = new Date();  
			    date.setTime(longTypeDate);  
			    dateType += date.getFullYear();   //年  
			    dateType += "-" + getMonth(date); //月   
			    dateType += "-" + getDay(date);   //日  
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
			var c = '<%=request.getParameter("c")%>';
			var editRow = undefined;
			var dg = $('#dg').datagrid({      
				url:'../../courseController/queryStudentByStuToCou.action?c='+c,   
		        rownumbers:true,  
		        pagination:false,  
		        fitColumns:'true',  
		        columns:[[      
		            {field:'ck',checkbox:true},      
		            {field:'student_id',width:50,align:'center',title:'学号'},    
		            {field:'student_name',width:100,align:'center',title:'姓名'},     
		            {field:'student_sex',width:50,align:'center',title:'性别'}, 
		            {field:'college_name',width:100,align:'center',title:'学院'},
		            {field:'student_entrydate',width:100,align:'center',title:'入学日期',
		            	formatter: function (value, row, index) {
		            		return dateFormat(value);
						}
		            },    
		            {field:'class_score',editor:'text',width:80,align:'center',title:'考试成绩',hidden:true}     
		        ]],
		        onAfterEdit: function (rowIndex, rowData, changes) {
                    //endEdit该方法触发此事件
                    console.info(rowData);
                    var data = {
                    	student_id : rowData.student_id,
                    	class_score : rowData.class_score
                    }
                    $.post("../../teacherController/updateStuToCouClassScore.action?c="+c,data,function(flag){
                    	alert(flag);
                    })
                    console.log(data);
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
			$("#back_btn").click(function(){
				window.location.href="myCourseOfTeacher.jsp";
			})
			$("#reload_btn").click(function(){
				$("#dg").datagrid("reload");
			})
			$("#score_btn").click(function(){
				$("#dg").datagrid("showColumn","class_score");
			})
			$("#delete_btn").click(function(){
				var s = $("#dg").datagrid("getSelections");
				if(s.length==0){
					$.messager.alert("错误提示",'请选择要删除的学生','error');
				}else{
					var studentIds = [];
					for(var i=0; i<s.length; i++){
						studentIds.push(s[i].student_id);
					}
					var sids = studentIds.join(",");
					$.post('../../teacherController/deleteStudentByTeacher.action?c='+c,{"student_id":sids},function(flag){
						alert(flag)
					})
				}
			})
			$("#undo_btn").click(function(){
				editRow = undefined;
                dg.datagrid("rejectChanges");
                dg.datagrid("unselectAll");
			})
			$("#save_btn").click(function(){
				dg.datagrid("endEdit", editRow);
			})
		})
	</script>
</head>
<body>
	<table id="dg" title="已选人数" class="easyui-datagrid" toolbar="#tb"></table>
	<div id="tb" style="display: none;">
		<a id="back_btn" class="easyui-linkbutton" data-options="iconCls:'icon-back'" plain="true">返回</a>
		<a id="delete_btn" class="easyui-linkbutton" data-options="iconCls:'icon-no'" plain="true">删除</a>
		<a id="reload_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" plain="true">刷新</a>
		<a id="score_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" plain="true">成绩</a>
		<a id="undo_btn" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" plain="true">撤销编辑</a>
		<a id="save_btn" class="easyui-linkbutton" data-options="iconCls:'icon-save'" plain="true">保存</a>
	</div>
</body>
</html>