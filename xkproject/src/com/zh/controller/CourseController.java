package com.zh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.service.CourseService;
import com.zh.service.LevelService;
import com.zh.service.StudentService;
import com.zh.vo.Course;
import com.zh.vo.PageBean;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;

@RequestMapping("/courseController")
@Controller
public class CourseController {
	@Resource
	private CourseService courseService;
	@Resource
	private LevelService levelService;
	@Resource
	private StudentService studentService;
	
	/**
	 * 分页查询所有课程，分页条件查询课程
	 * @param course
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("queryAllCourse")
	@ResponseBody
	public Map<String,Object> queryAllCourse(@Param("course") Course course,@Param("page") int page,@Param("rows") int rows) {
		PageBean pageBean = new PageBean((page-1)*rows,rows);
		int count = courseService.getAllCourseCount(course);
		Map<String,Object> courseMap = new HashMap<>();
		List<Course> cl = courseService.queryAllCourse(course,pageBean);
		courseMap.put("rows", cl);
		courseMap.put("total", count);
		return courseMap;
	}
	/**
	 * 根据stuToCou的课程ID、课程地点、时间和学期ID查询课程的所选学生
	 * @param c
	 * @return
	 */
	@RequestMapping("/queryStudentByStuToCou")
	@ResponseBody
	public List<Student> queryStudentByStuToCou(@Param("c") String c){
		String[] s = c.split(",");
		StuToCou stuToCou = new StuToCou();			
		stuToCou.setClass_id(s[0]);
		stuToCou.setClass_place(s[1]);
		stuToCou.setClass_weekday(s[2]);
		stuToCou.setTime_id(Integer.parseInt(s[3]));
		stuToCou.setTerm_id(Integer.parseInt(s[4]));
		return courseService.queryStudentByStuToCou(stuToCou);
	}
}
