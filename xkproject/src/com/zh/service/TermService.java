package com.zh.service;

import java.util.List;

import com.zh.vo.Student;
import com.zh.vo.Term;

public interface TermService {
	public List<Term> queryAllTermByStudent(Student student);
}
