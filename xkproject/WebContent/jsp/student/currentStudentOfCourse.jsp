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
			var r = $("#dg").datagrid("getColumnOption","student_entrydate");
			r.formatter = function cal(value,row){
				return dateFormat(value);
			}
			$("#back_btn").click(function(){
				window.location.href="courseInfo.jsp";
			})
		})
	</script>
</head>
<body>
	<table id="dg" title="已选人数" class="easyui-datagrid" fitColumns="true"
	 pagination="false" rownumbers="true" url="../../courseController/queryStudentByStuToCou.action?c=<%=request.getParameter("c") %>" fit="true"  toolbar="#tb">
		<thead>
			<tr>
				<th field="student_id" width="50"  align="center">学号</th>
				<th field="student_name" width="100" align="center">姓名</th>
				<th field="student_sex" width="100" align="center" >性别</th>
				<th field="college_name" width="100" align="center">学院名称</th>
				<th field="student_entrydate" width="100"  align="center">入学日期</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="display: none;">
		<a id="back_btn" class="easyui-linkbutton" data-options="iconCls:'icon-back'" plain="true">返回</a>
	</div>
</body>
</html>