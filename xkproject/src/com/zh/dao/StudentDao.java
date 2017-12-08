package com.zh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;
import com.zh.vo.Term;

public interface StudentDao {
	//学生登录
	public Student studentLogin(@Param("student") Student student);
	//学生信息修改
	public void editStudentInfo(@Param("student") Student student);
	//查询学生所选课程
	public List<Course> queryCourseByStudent(@Param("student") Student student,@Param("term") Term term);
	//查询学生考试成绩
	public List<Course> queryScoreByStudent(@Param("student") Student student,@Param("term") Term term);
	//从中间表StuToCou中查询记录
	public StuToCou queryFromMyCourseByStuToCou(@Param("stuToCou") StuToCou stuToCou);
	public void addToMyCourse(@Param("stuToCou") StuToCou stuToCou);
	public void deleteFromMyCourse(@Param("stuToCou") StuToCou stuToCou);
	public void addCurrentQuantityByStuToCou(@Param("stuToCou") StuToCou stuToCou);
	public void minusCurrentQuantityByStuToCou(@Param("stuToCou") StuToCou stuToCou);
}
