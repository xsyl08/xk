package com.zh.service;

import java.util.List;

import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;
import com.zh.vo.Term;

public interface StudentService {
	public Student studentLogin(Student student);
	public void editStudentInfo(Student student);
	public List<Course> queryCourseByStudent(Student student,Term term);
	public List<Course> queryScoreByStudent(Student student,Term term);
	public StuToCou queryFromMyCourseByStuToCou(StuToCou stuToCou);
	public void addToMyCourse(StuToCou stuToCou);
	public void deleteFromMyCourse(StuToCou stuToCou);
	public void addCurrentQuantityByStuToCou(StuToCou stuToCou);
	public void minusCurrentQuantityByStuToCou(StuToCou stuToCou);
}
