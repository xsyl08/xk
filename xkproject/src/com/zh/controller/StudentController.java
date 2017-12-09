package com.zh.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.service.CourseService;
import com.zh.service.StudentService;
import com.zh.util.DateUtil;
import com.zh.util.StringUtil;
import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;
import com.zh.vo.Term;
import com.zh.vo.WeekDay;

@SuppressWarnings("deprecation")
@RequestMapping("/studentController")
@Controller
public class StudentController {
	@Resource
	private StudentService studentService;
	@Resource
	private CourseService courseService;
	/**
	 * 学生登录，登录成功将学生信息保存到session中
	 * @param student
	 * @param req
	 * @return
	 */
	@RequestMapping("/studentLogin")
	public String studentLogin(@Param("student") Student student, HttpServletRequest req) {
		student = studentService.studentLogin(student);
		if(student!=null) {
			student.setStudent_age(2017-DateUtil.getYear(student.getStudent_birthday()));
			req.getSession().setAttribute("currentStudent", student);
			return "jsp/student/studentIndex";
		}
		return "redirect:../studentLogin.jsp";
	}
	/**
	 * 注销登录，将学生信息从session中清除
	 * @param req
	 * @return
	 */
	@RequestMapping("/studentLogout")
	public String studentLogout(HttpServletRequest req) {
		req.getSession().removeAttribute("currentStudent");
		return "redirect:../studentLogin.jsp";
	}
	/**
	 * 查询学生个人信息
	 * @param req
	 * @return
	 */
	@RequestMapping("/queryStudentInfo")
	@ResponseBody
	public List<Student> queryStudentInfo(HttpServletRequest req) {
		Student student = (Student) req.getSession().getAttribute("currentStudent");
		List<Student> sl = new ArrayList<>();
		sl.add(student);
		return sl;
	}
	/**
	 * 修改学生个人信息
	 * @param student
	 * @return
	 */
	@RequestMapping("/editStudentInfo")
	@ResponseBody
	public String editStudentInfo(@Param("student") Student student) {
		studentService.editStudentInfo(student);
		return "ok";
	}
	/**
	 * 根据保存在session中的学生信息和学期查询每学期课表
	 * @param req
	 * @param term
	 * @return
	 */
	@RequestMapping("queryCourseByStudent")
	@ResponseBody
	public List<WeekDay> queryCourseByStudent(HttpServletRequest req,@Param("term")Term term) {
		//获取当前登录学生信息
		Student student = (Student) req.getSession().getAttribute("currentStudent");
		List<Course> cl = studentService.queryCourseByStudent(student,term);
		List<WeekDay> wl = new ArrayList<>();
		for(int i=0; i<13; i++) {
			WeekDay wd = new WeekDay();
			for(Course c:cl) {
				String weekday = c.getClass_weekday();
				List<Integer> il = StringUtil.getArray((c.getTime_detail()));
				if("周一".equals(weekday)&&il.contains(i+1)) {
					wd.setMonday(c);
				}else if(weekday.equals("周二")&&il.contains(i+1)) {
					wd.setTuesday(c);
				}else if(weekday.equals("周三")&&il.contains(i+1)) {
					wd.setWendsday(c);
				}else if(weekday.equals("周四")&&il.contains(i+1)) {
					wd.setThursday(c);
				}else if(weekday.equals("周五")&&il.contains(i+1)) {
					wd.setFriday(c);
				}else if(weekday.equals("周六")&&il.contains(i+1)) {
					wd.setSaturday(c);
				}else if(weekday.equals("周日")&&il.contains(i+1)) {
					wd.setSunday(c);
				}
			}
			wl.add(wd);
		}
		return wl;
	}
	/**
	 * 查询学生考试成绩
	 * @param req
	 * @param term
	 * @return
	 */
	@RequestMapping("/queryScoreByStudent")
	@ResponseBody
	public List<Course> queryScoreByStudent(HttpServletRequest req,@Param("term") Term term){
		Student student = (Student) req.getSession().getAttribute("currentStudent");
		List<Course> cl = studentService.queryScoreByStudent(student,term);
		return cl;
	}
	/**
	 * 查询学生和课程中间表中是否有此条记录，有返回true，没有返回false
	 * @param stuToCou
	 * @return
	 */
	@RequestMapping("queryFromMyCourseByStuToCou")
	@ResponseBody
	public boolean queryFromMyCourseByStuToCou(StuToCou stuToCou) {
		boolean flag = false;
		if(studentService.queryFromMyCourseByStuToCou(stuToCou)!=null) {
			flag = true;
		}
		return flag;
	}
	/**
	 * 根据stuToCou的学生ID、课程ID、课程地点、时间和学期ID把课程添加到学生课表中，同时增加此课程的当前选课人数
	 * @param stuToCous
	 * @param req
	 * @param term
	 * @return
	 */
	@RequestMapping("addToMyCourse")
	@ResponseBody
	public String addToMyCourse(@Param("stuToCous") String stuToCous, HttpServletRequest req, @Param("term") Term term) {
		Student student = (Student) req.getSession().getAttribute("currentStudent");
		String[] stcs = stuToCous.split(",");
		for(int i=0; i<stcs.length; i+=4) {
			StuToCou stuToCou = new StuToCou();
			stuToCou.setClass_id(stcs[i]);
			stuToCou.setClass_place(stcs[i+1]);
			stuToCou.setClass_weekday(stcs[i+2]);
			stuToCou.setTime_id(Integer.parseInt(stcs[i+3]));
			stuToCou.setStudent_id(student.getStudent_id());
			stuToCou.setTerm_id(term.getTerm_id());
			boolean flag = true;
			//此条记录已经在表中存在的话，不执行，不存在才添加到表中
			if(!queryFromMyCourseByStuToCou(stuToCou)){
				//课程已选人数小于课程最大人数，记录才可以添加到表中，同时更新课程的已选人数
				if(courseService.queryCourseByStuToCou(stuToCou).getCurrentquantity()<courseService.queryCourseByStuToCou(stuToCou).getClass_capacity()) {
					List<Course> cl = studentService.queryCourseByStudent(student,term);
					for(Course c:cl) {
						if(stuToCou.getClass_place().equals(c.getClass_place())) {
							flag = false;
							return "placeerror";
						}
						if(stuToCou.getClass_weekday().equals(c.getClass_weekday())) {
							if(StringUtil.haveSameElement(c.getTime_detail(), courseService.queryCourseByStuToCou(stuToCou).getTime_detail())) {
								flag = false;
								return "timeerror";
							}
						}
					}
				}
			}
			if(flag) {
				studentService.addToMyCourse(stuToCou);
				studentService.addCurrentQuantityByStuToCou(stuToCou);
			}
		}
		return "OK";
	}
	/**
	 * 根据stuToCou的学生ID、课程ID、课程地点、时间和学期ID从个人课表中删除，同时减少此课程的当前选课人数
	 * @param stc
	 * @param req
	 * @return
	 */
	@RequestMapping("deleteFromMyCourse")
	public String deleteFromMyCourse(@Param("stc") String stc, HttpServletRequest req) {
			Student student = (Student) req.getSession().getAttribute("currentStudent");
			String[] s = stc.split(",");
			StuToCou stuToCou = new StuToCou();			
			stuToCou.setStudent_id(student.getStudent_id());
			stuToCou.setClass_id(s[0]);
			stuToCou.setClass_place(s[1]);
			stuToCou.setClass_weekday(s[2]);
			stuToCou.setTime_id(Integer.parseInt(s[3]));
			stuToCou.setTerm_id(Integer.parseInt(s[4]));
			studentService.deleteFromMyCourse(stuToCou);
			if(courseService.queryCourseByStuToCou(stuToCou).getCurrentquantity()>=1) {
				studentService.minusCurrentQuantityByStuToCou(stuToCou);
			}
		return "redirect:../jsp/student/myCourse.jsp";
	}
	/**
	 * 将学生个人课表导出到Excel表格
	 * @param resp
	 * @param req
	 * @param term
	 */
	@RequestMapping("exportMyCourse")
	public void exportMyCourse(HttpServletResponse resp,HttpServletRequest req,@Param("term") Term term){
		// 创建Excel的工作书册 Workbook,对应到一个excel文档
		HSSFWorkbook wb = new HSSFWorkbook();
		// 创建Excel的工作sheet,对应到一个excel文档的tab
		HSSFSheet sheet = wb.createSheet("sheet1");
		// 设置excel每列宽度
		sheet.setColumnWidth(0, 5000);
		sheet.setColumnWidth(1, 4500);
		// 创建字体样式
		HSSFFont font = wb.createFont();
		font.setFontName("Verdana");
		font.setBoldweight((short) 100);
		font.setFontHeight((short) 300);
		font.setColor(HSSFColor.BLUE.index);
		// 创建单元格样式
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置边框
		style.setBottomBorderColor(HSSFColor.RED.index);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);

		style.setFont(font);// 设置字体
		style.setWrapText(true);// 自动换行
		// 创建Excel的sheet的一行
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 500);// 设定行的高度
		HSSFCell cell=null;
		// 创建一个Excel的单元格
		String[] cellTitle = {"时间", "周一", "周二","周三", "周四", "周五","周六","周日"};	
		for (int i = 0; i < cellTitle.length; i++) {
			cell = row.createCell(i);
			// 给Excel的单元格设置样式和赋值
			cell.setCellStyle(style);
			cell.setCellValue(cellTitle[i]);
		}
		term.setTerm_id(35);
		List<WeekDay> wl = queryCourseByStudent(req, term);
		HSSFCellStyle s = wb.createCellStyle();
		s.setWrapText(true);
		int rowIndex=1;
		while(rowIndex<wl.size()+1){
			row = sheet.createRow(rowIndex);
			cell = row.createCell(0);
			cell.setCellValue(rowIndex);
			cell = row.createCell(1);
			cell.setCellStyle(s);
			int r = 0;
			int c = 1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getMonday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getMonday().getClass_name()+"\n"+wl.get(rowIndex-1).getMonday().getClass_place()+"\n"+
						wl.get(rowIndex-1).getMonday().getTime_detail()+"\n"+wl.get(rowIndex-1).getMonday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getMonday()!=null) {
						if(wl.get(i).getMonday().getClass_name().equals(wl.get(rowIndex-1).getMonday().getClass_name())) {
							r = rowIndex;
							c = c+1;
							CellRangeAddress cr = new CellRangeAddress(r, r+c-1, 1, 1);
							sheet.addMergedRegion(cr);
						}
					}
				}
			}else {
				cell.setCellValue("");
			}
			cell = row.createCell(2);
			cell.setCellStyle(s);
			int r2=0;
			int c2=1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getTuesday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getTuesday().getClass_name()+"\n"+wl.get(rowIndex-1).getTuesday().getClass_place()+"\n"+
								  wl.get(rowIndex-1).getTuesday().getTime_detail()+"\n"+wl.get(rowIndex-1).getTuesday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getTuesday()!=null) {
						if(wl.get(i).getTuesday().getClass_name().equals(wl.get(rowIndex-1).getTuesday().getClass_name())) {
							r2 = rowIndex;
							c2 = c2+1;
							CellRangeAddress cr = new CellRangeAddress(r2, r2+c2-1, 2, 2);
							sheet.addMergedRegion(cr);
						}
						
					}
				}
			}else {
				cell.setCellValue("");
			}
			cell = row.createCell(3);
			cell.setCellStyle(s);
			int r3=0;
			int c3=1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getWendsday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getWendsday().getClass_name()+"\n"+wl.get(rowIndex-1).getWendsday().getClass_place()+"\n"+
						wl.get(rowIndex-1).getWendsday().getTime_detail()+"\n"+wl.get(rowIndex-1).getWendsday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getWendsday()!=null) {
						if(wl.get(i).getWendsday().getClass_name().equals(wl.get(rowIndex-1).getWendsday().getClass_name())) {
							r3 = rowIndex;
							c3 = c3+1;
							CellRangeAddress cr = new CellRangeAddress(r3, r3+c3-1, 3, 3);
							sheet.addMergedRegion(cr);
						}
						
					}
				}
			}else {
				cell.setCellValue("");
			}
			cell = row.createCell(4);
			cell.setCellStyle(s);
			int r4=0;
			int c4=1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getThursday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getThursday().getClass_name()+"\n"+wl.get(rowIndex-1).getThursday().getClass_place()+"\n"+
						wl.get(rowIndex-1).getThursday().getTime_detail()+"\n"+wl.get(rowIndex-1).getThursday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getThursday()!=null) {
						if(wl.get(i).getThursday().getClass_name().equals(wl.get(rowIndex-1).getThursday().getClass_name())) {
							r4 = rowIndex;
							c4 = c4+1;
							CellRangeAddress cr = new CellRangeAddress(r4, r4+c4-1, 4, 4);
							sheet.addMergedRegion(cr);
						}
						
					}
				}
			}else {
				cell.setCellValue("");
			}
			cell = row.createCell(5);
			cell.setCellStyle(s);
			int r5=0;
			int c5=1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getFriday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getFriday().getClass_name()+"\n"+wl.get(rowIndex-1).getFriday().getClass_place()+"\n"+
						wl.get(rowIndex-1).getFriday().getTime_detail()+"\n"+wl.get(rowIndex-1).getFriday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getFriday()!=null) {
						if(wl.get(i).getFriday().getClass_name().equals(wl.get(rowIndex-1).getFriday().getClass_name())) {
							r5 = rowIndex;
							c5 = c5+1;
							CellRangeAddress cr = new CellRangeAddress(r5, r5+c5-1, 5, 5);
							sheet.addMergedRegion(cr);
						}
						
					}
				}
			}else {
				cell.setCellValue("");
			}
			cell = row.createCell(6);
			cell.setCellStyle(s);
			int r6=0;
			int c6=1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getSaturday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getSaturday().getClass_name()+"\n"+wl.get(rowIndex-1).getSaturday().getClass_place()+"\n"+
						wl.get(rowIndex-1).getSaturday().getTime_detail()+"\n"+wl.get(rowIndex-1).getSaturday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getSaturday()!=null) {
						if(wl.get(i).getSaturday().getClass_name().equals(wl.get(rowIndex-1).getSaturday().getClass_name())) {
							r6 = rowIndex;
							c6 = c6+1;
							CellRangeAddress cr = new CellRangeAddress(r6, r6+c6-1, 6, 6);
							sheet.addMergedRegion(cr);
						}
						
					}
				}
			}else {
				cell.setCellValue("");
			}
			cell = row.createCell(7);
			cell.setCellStyle(s);
			int r7=0;
			int c7=1;
			if(wl.get(rowIndex-1)!=null&&wl.get(rowIndex-1).getSunday()!=null) {
				cell.setCellValue(wl.get(rowIndex-1).getSunday().getClass_name()+"\n"+wl.get(rowIndex-1).getSunday().getClass_place()+"\n"+
						wl.get(rowIndex-1).getSunday().getTime_detail()+"\n"+wl.get(rowIndex-1).getSunday().getTeacher_name());
				for(int i=rowIndex;i<wl.size();i++) {
					if(wl.get(i)!=null&&wl.get(i).getSunday()!=null) {
						if(wl.get(i).getSunday().getClass_name().equals(wl.get(rowIndex-1).getSunday().getClass_name())) {
							r7 = rowIndex;
							c7 = c7+1;
							CellRangeAddress cr = new CellRangeAddress(r7, r7+c7-1, 7, 7);
							sheet.addMergedRegion(cr);
						}
						
					}
				}
			}else {
				cell.setCellValue("");
			}
			rowIndex++;
		}
		String exportFileName = "mycourse.xls";
		try {
			resp.setHeader("Content-Disposition", "attachment;filename=" + new String((exportFileName).getBytes(), "ISO8859-1"));//设定输出文件头
			resp.setContentType("application/vnd.ms-excel;charset=UTF-8");// 定义输出类型

			OutputStream out = resp.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
