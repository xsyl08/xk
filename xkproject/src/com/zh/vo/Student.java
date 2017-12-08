package com.zh.vo;

import java.util.Date;

public class Student {
	private String student_id;//学号
	private String student_name;//姓名
	private String student_pwd;//密码
	private String student_sex;//性别
	private Date student_birthday;//出生日期
	private int student_age;//年龄
	private Date student_entrydate;//入学日期
	private int college_id;//学院编号
	private String college_name;//学院名称
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public String getStudent_pwd() {
		return student_pwd;
	}
	public void setStudent_pwd(String student_pwd) {
		this.student_pwd = student_pwd;
	}
	public String getStudent_sex() {
		return student_sex;
	}
	public void setStudent_sex(String student_sex) {
		this.student_sex = student_sex;
	}
	public Date getStudent_birthday() {
		return student_birthday;
	}
	public void setStudent_birthday(Date student_birthday) {
		this.student_birthday = student_birthday;
	}
	public int getStudent_age() {
		return student_age;
	}
	public void setStudent_age(int student_age) {
		this.student_age = student_age;
	}
	public Date getStudent_entrydate() {
		return student_entrydate;
	}
	public void setStudent_entrydate(Date student_entrydate) {
		this.student_entrydate = student_entrydate;
	}
	public int getCollege_id() {
		return college_id;
	}
	public void setCollege_id(int college_id) {
		this.college_id = college_id;
	}
	public String getCollege_name() {
		return college_name;
	}
	public void setCollege_name(String college_name) {
		this.college_name = college_name;
	}
}
