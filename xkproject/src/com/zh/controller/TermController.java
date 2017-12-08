package com.zh.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.service.TermService;
import com.zh.vo.Student;
import com.zh.vo.Term;

@RequestMapping("/termController")
@Controller
public class TermController {
	@Resource
	private TermService termService;
	
	@RequestMapping("/queryAllTermByStudent")
	@ResponseBody
	public List<Term> queryAllTermByStudent(HttpServletRequest req){
		Student student = (Student) req.getSession().getAttribute("currentStudent");
		return termService.queryAllTermByStudent(student);
	}
}
