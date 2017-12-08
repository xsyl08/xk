package com.zh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zh.dao.TermDao;
import com.zh.vo.Student;
import com.zh.vo.Term;

@Service("termService")
public class TermServiceImp implements TermService {
	@Resource
	private TermDao termDao;

	@Override
	public List<Term> queryAllTermByStudent(Student student) {
		// TODO Auto-generated method stub
		return termDao.queryAllTermByStudent(student);
	}

}
