package com.zh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.zh.vo.Course;
import com.zh.vo.PageBean;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;

public interface CourseDao {
	//分页查询符合条件的课程
	public List<Course> queryAllCourse(@Param("course") Course course,@Param("pageBean") PageBean pageBean);
	//获取符合查询条件的课程记录数
	public int getAllCourseCount(@Param("course") Course course);
	//根据课程ID查询本门课程的选课学生
	public List<Student> queryStudentByStuToCou(@Param("stuToCou") StuToCou stuToCou);
	public Course queryCourseByStuToCou(@Param("stuToCou") StuToCou stuToCou);
}
