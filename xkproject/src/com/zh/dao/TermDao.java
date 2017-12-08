package com.zh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zh.vo.Student;
import com.zh.vo.Term;

public interface TermDao {
	public List<Term> queryAllTermByStudent(@Param("student") Student student);
}
