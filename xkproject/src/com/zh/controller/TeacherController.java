package com.zh.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.service.CourseService;
import com.zh.service.LevelService;
import com.zh.service.StudentService;
import com.zh.service.TeacherService;
import com.zh.vo.Course;
import com.zh.vo.Level;
import com.zh.vo.StuToCou;
import com.zh.vo.Teacher;

@RequestMapping("/teacherController")
@Controller
public class TeacherController {
	@Resource
	private TeacherService teacherService;
	@Resource
	private LevelService levelService;
	@Resource
	private StudentService studentService;
	@Resource
	private CourseService courseService;

	/**
	 * 教师登录
	 * @param teacher
	 * @param session
	 * @return
	 */
	@RequestMapping("/teacherLogin")
	public String teacherLogin(@Param("teacher") Teacher teacher, HttpSession session) {
		teacher = teacherService.teacherLogin(teacher);
		if(teacher!=null) {
			session.setAttribute("currentTeacher", teacher);
			return "jsp/teacher/teacherIndex";
		}
		return "redirect:../teacherLogin.jsp";
	}
	/**
	 * 教师查询个人信息
	 * @param req
	 * @return
	 */
	@RequestMapping("/queryTeacherInfo")
	@ResponseBody
	public List<Teacher> queryTeacherInfo(HttpServletRequest req) {
		Teacher teacher = (Teacher) req.getSession().getAttribute("currentTeacher");
		List<Teacher> tl = new ArrayList<>();
		tl.add(teacher);
		return tl;
	}
	/**
	 * 教师注销登录
	 * @param session
	 * @return
	 */
	@RequestMapping("/teacherLogout")
	public String teacherLogout(HttpSession session) {
		session.removeAttribute("currentTeacher");
		return "redirect:../teacherLogin.jsp";
	}
	/**
	 * 教师编辑个人信息
	 * @param teacher
	 * @return
	 */
	@RequestMapping("/editTeacherInfo")
	@ResponseBody
	public String editTeacherInfo(@Param("teacher") Teacher teacher) {
		teacherService.editTeacherInfo(teacher);
		return "ok";
	}
	/**
	 * 查询自己开设课程
	 * @param session
	 * @return
	 */
	@RequestMapping("queryCourseByTeacher")
	@ResponseBody
	public List<Course> queryCourseByTeacher(HttpSession session) {
		Teacher teacher = (Teacher) session.getAttribute("currentTeacher");
		List<Course> cl = teacherService.queryCourseByTeacher(teacher);
		return cl;
	}
	/**
	 * 更新成绩
	 * @param stuToCou
	 * @param c
	 * @return
	 */
	@RequestMapping("updateStuToCouClassScore")
	@ResponseBody
	public String updateStuToCouClassScore(@Param("stuToCou") StuToCou stuToCou,@Param("c") String c) {
		String[] s = c.split(",");
		stuToCou.setClass_id(s[0]);
		stuToCou.setClass_place(s[1]);
		stuToCou.setClass_weekday(s[2]);
		stuToCou.setTime_id(Integer.parseInt(s[3]));
		stuToCou.setTerm_id(Integer.parseInt(s[4]));
		Level level = levelService.queryLevelByClassScore(stuToCou.getClass_score());
		stuToCou.setLevel_id(level.getLevel_id());
		Course course = courseService.queryCourseByStuToCou(stuToCou);
		if(stuToCou.getClass_score()>60) {
			stuToCou.setGetgrade(course.getClass_grade());
			stuToCou.setScore_point(((int)stuToCou.getClass_score())/10.0-5);
		}
		teacherService.updateStuToCouClassScore(stuToCou);
		return "ok";
	}
	/**
	 * 删除本门课程选修学生
	 * @param c
	 * @param student_id
	 * @return
	 */
	@RequestMapping("deleteStudentByTeacher")
	@ResponseBody
	public String deleteStudentByTeacher(@Param("c") String c,@Param("student_id") String student_id) {
		String[] sids = student_id.split(",");
		String[] s = c.split(",");
		for(String sid:sids) {
			StuToCou stuToCou = new StuToCou();			
			stuToCou.setClass_id(s[0]);
			stuToCou.setClass_place(s[1]);
			stuToCou.setClass_weekday(s[2]);
			stuToCou.setTime_id(Integer.parseInt(s[3]));
			stuToCou.setTerm_id(Integer.parseInt(s[4]));
			stuToCou.setStudent_id(sid);
			studentService.deleteFromMyCourse(stuToCou);
			if(courseService.queryCourseByStuToCou(stuToCou).getCurrentquantity()>=1) {
				studentService.minusCurrentQuantityByStuToCou(stuToCou);
			}
		}
		return "ok";
	}
	@RequestMapping("/addOrModifyCourse")
	@ResponseBody
	public String addOrModifyCourse(@Param("course") Course course,HttpSession session) {
		Teacher teacher = (Teacher) session.getAttribute("currentTeacher");
		//首先判断是新增课程还是修改课程
		Course c = teacherService.queryCourseByCourseId(course.getClass_id());
		course.setTeacher_id(teacher.getTeacher_id());
		course.setTerm_id(35);
		if(c!=null) {
			teacherService.modifyCourse(course);
			teacherService.modifyClassTime(course);
		}else {
			teacherService.addCourse(course);
			teacherService.addClassTime(course);
		}
		return "ok";
	}
}
