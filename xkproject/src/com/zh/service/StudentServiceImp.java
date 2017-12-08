package com.zh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zh.dao.StudentDao;
import com.zh.vo.Course;
import com.zh.vo.StuToCou;
import com.zh.vo.Student;
import com.zh.vo.Term;

@Service("studentService")
public class StudentServiceImp implements StudentService {
	@Resource
	private StudentDao studentDao;

	@Override
	public Student studentLogin(Student student) {
		// TODO Auto-generated method stub
		return studentDao.studentLogin(student);
	}

	@Override
	public void editStudentInfo(Student student) {
		// TODO Auto-generated method stub
		studentDao.editStudentInfo(student);
	}

	@Override
	public List<Course> queryCourseByStudent(Student student,Term term) {
		// TODO Auto-generated method stub
		return studentDao.queryCourseByStudent(student,term);
	}
	
	@Override
	public List<Course> queryScoreByStudent(Student student,Term term) {
		// TODO Auto-generated method stub
		return studentDao.queryScoreByStudent(student,term);
	}

	@Override
	public StuToCou queryFromMyCourseByStuToCou(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		return studentDao.queryFromMyCourseByStuToCou(stuToCou);
	}
	
	@Override
	public void addToMyCourse(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		studentDao.addToMyCourse(stuToCou);
	}

	@Override
	public void deleteFromMyCourse(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		studentDao.deleteFromMyCourse(stuToCou);
	}

	@Override
	public void addCurrentQuantityByStuToCou(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		studentDao.addCurrentQuantityByStuToCou(stuToCou);
	}

	@Override
	public void minusCurrentQuantityByStuToCou(StuToCou stuToCou) {
		// TODO Auto-generated method stub
		studentDao.minusCurrentQuantityByStuToCou(stuToCou);
	}

}
