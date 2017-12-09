<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生个人课表</title>
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../insdep-1.0.4/themes/insdep/icon.css">
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/jquery.easyui-1.5.1.min.js"></script>
	<script type="text/javascript" src="../../insdep-1.0.4/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var term= null;
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
			$('#dg').datagrid({
			    url:'../../studentController/queryCourseByStudent.action',
			    onLoadSuccess: onLoadSuccess,
			    fit:true,
			    toolbar:'#tb',
			    columns:[[
			    	{field:'cd',title:'时间',width:'5%',align:'center',
			    		formatter:function(value,row,index){
			    			return index+1;
			    		}},
			        {field:'monday',title:'周一',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}},   
			       	{field:'tuesday',title:'周二',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}},
			        {field:'wendsday',title:'周三',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}},
			        {field:'thursday',title:'周四',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}},
			        {field:'friday',title:'周五',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}},
			        {field:'saturday',title:'周六',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}},
			        {field:'sunday',title:'周日',width:'12%',align:'center',
			    		formatter:function(value,row,index){
			    			if(value!=""&&value!=null){
			    				var stuToCou = [];
								stuToCou.push(value.class_id);
								stuToCou.push(value.class_place);
								stuToCou.push(value.class_weekday);
								stuToCou.push(value.time_id);
								stuToCou.push(value.term_id);
								var data = stuToCou.join(",");
			    				return value.class_name+"<br/>"+value.teacher_name+"<br/>"+value.class_place+"<br/>"+value.time_detail+
			    						"<br/><a href='../../studentController/deleteFromMyCourse.action?stc="+data+"'"+">删除</a>";
			    			}
			    			return value;
			    		}}  
			    ]]   
			})
			$("#reload_btn").click(function(){
				$("#dg").datagrid('reload');
			})
		})
		function onLoadSuccess(data){
			//周一
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].monday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].monday!=null){
							if(data.rows[i].monday.class_name == data.rows[j].monday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'monday'
	                        })
						}
					}
				}
			}
			//周二
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].tuesday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].tuesday!=null){
							if(data.rows[i].tuesday.class_name == data.rows[j].tuesday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'tuesday'
	                        })
						}
					}
				}
			}
			//周三
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].wendsday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].wendsday!=null){
							if(data.rows[i].wendsday.class_name == data.rows[j].wendsday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'wendsday'
	                        })
						}
					}
				}
			}
			//周四
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].thursday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].thursday!=null){
							if(data.rows[i].thursday.class_name == data.rows[j].thursday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'thursday'
	                        })
						}
					}
				}
			}
			//周五
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].friday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].friday!=null){
							if(data.rows[i].friday.class_name == data.rows[j].friday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'friday'
	                        })
						}
					}
				}
			}
			//周六
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].saturday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].thursday!=null){
							if(data.rows[i].saturday.class_name == data.rows[j].saturday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'saturday'
	                        })
						}
					}
				}
			}
			//周日
			for(i=0; i<12; i++){
				var x1=0; y1=1;
				if(data.rows[i].sunday!=null){
					for(j=i+1;j<13;j++){
						if(data.rows[j].sunday!=null){
							if(data.rows[i].sunday.class_name == data.rows[j].sunday.class_name){
								x1 = i;
								y1 = 1+y1;
							}
							$(this).datagrid('mergeCells', {
	                            index: x1,
	                            rowspan: y1,
	                            field: 'sunday'
	                        })
						}
					}
				}
			}
		}
	</script>
</head>
<body>
	<table id="dg">
	</table>
	<div id="tb">
		<span>学号：${currentStudent.student_id }</span>&nbsp;&nbsp;&nbsp;&nbsp;
		<span>姓名：${currentStudent.student_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
		<input id="term" class="easyui-combobox" name="term" editable="false"
			data-options="valueField:'term_id',textField:'term_name',panelHeight:'auto',
				url:'../../termController/queryAllTermByStudent.action'" />&nbsp;&nbsp;
		<a id="reload_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" plain="true">刷新</a>
		<a id="xls_btn" href="../../studentController/exportMyCourse.action" class="easyui-linkbutton" data-options="iconCls:'icon-search'" plain="true">导出Excel</a>
	</div>
</body>
</html>