package com.zh.service;

import java.util.List;

import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Teacher;

public interface TeacherService {
	public Teacher teacherLogin(Teacher teacher);
	public void editTeacherInfo(Teacher teacher);
	public List<Course> queryCourseByTeacher(Teacher teacher);
	public void updateStuToCouClassScore(StuToCou stuToCou);
	public Course queryCourseByCourseId(String class_id);
	public void addCourse(Course course);
	public void addClassTime(Course course);
	public void modifyCourse(Course course);
	public void modifyClassTime(Course course);
}
