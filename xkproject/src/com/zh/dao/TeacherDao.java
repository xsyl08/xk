package com.zh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Teacher;

public interface TeacherDao {
	public Teacher teacherLogin(@Param("teacher") Teacher teacher);
	public void editTeacherInfo(@Param("teacher") Teacher teacher);
	public List<Course> queryCourseByTeacher(@Param("teacher") Teacher teacher);
	public void updateStuToCouClassScore(@Param("stuToCou") StuToCou stuToCou);
	public Course queryCourseByCourseId(@Param("class_id") String class_id);
	public void addCourse(@Param("course") Course course);
	public void addClassTime(@Param("course") Course course);
	public void modifyCourse(@Param("course") Course course);
	public void modifyClassTime(@Param("course") Course course);
}
