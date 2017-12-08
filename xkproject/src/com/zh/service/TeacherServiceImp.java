package com.zh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zh.dao.TeacherDao;
import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Teacher;

@Service("teacherService")
public class TeacherServiceImp implements TeacherService {
	@Resource
	private TeacherDao teacherDao;

	@Override
	public Teacher teacherLogin(Teacher teacher) {
		// TODO Auto-generated method stub
		return teacherDao.teacherLogin(teacher);
	}

	@Override
	public void editTeacherInfo(Teacher teacher) {
		// TODO Auto-generated method stub
		teacherDao.editTeacherInfo(teacher);
	}

	@Override
	public List<Course> queryCourseByTeacher(Teacher teacher) {
		// TODO Auto-generated method stub
		return teacherDao.queryCourseByTeacher(teacher);
	}

	@Override
	public void updateStuToCouClassScore(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		teacherDao.updateStuToCouClassScore(stuToCou);
	}

	@Override
	public Course queryCourseByCourseId(String class_id) {
		// TODO Auto-generated method stub
		return teacherDao.queryCourseByCourseId(class_id);
	}

	@Override
	public void addCourse(Course course) {
		// TODO Auto-generated method stub
		teacherDao.addCourse(course);
	}

	@Override
	public void addClassTime(Course course) {
		// TODO Auto-generated method stub
		teacherDao.addClassTime(course);
	}

	@Override
	public void modifyCourse(Course course) {
		// TODO Auto-generated method stub
		teacherDao.modifyCourse(course);
	}

	@Override
	public void modifyClassTime(Course course) {
		// TODO Auto-generated method stub
		teacherDao.modifyClassTime(course);
	}

}
