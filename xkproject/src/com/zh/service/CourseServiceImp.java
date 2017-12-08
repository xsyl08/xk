package com.zh.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.zh.dao.CourseDao;
import com.zh.vo.Course;
import com.zh.vo.PageBean;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;

@Service("courseService")
public class CourseServiceImp implements CourseService {
	@Resource
	private CourseDao courseDao;

	@Override
	public List<Course> queryAllCourse(Course course, PageBean pageBean) {
		// TODO Auto-generated method stub
		return courseDao.queryAllCourse(course, pageBean);
	}

	@Override
	public int getAllCourseCount(@Param("course") Course course) {
		return courseDao.getAllCourseCount(course);
	}
	
	@Override
	public List<Student> queryStudentByStuToCou(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		return courseDao.queryStudentByStuToCou(stuToCou);
	}

	@Override
	public Course queryCourseByStuToCou(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		return courseDao.queryCourseByStuToCou(stuToCou);
	}

}
