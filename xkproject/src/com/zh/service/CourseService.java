package com.zh.service;

import java.util.List;

import com.zh.vo.Course;
import com.zh.vo.PageBean;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;

public interface CourseService {
	public List<Course> queryAllCourse(Course course, PageBean pageBean);
	public int getAllCourseCount(Course course);
	public List<Student> queryStudentByStuToCou(StuToCou stuToCou);
	public Course queryCourseByStuToCou(StuToCou stuToCou);
}
