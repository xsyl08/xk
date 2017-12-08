package com.zh.vo;

public class Course {
	private String class_id;//课程编号
	private String class_name;//课程名称
	private int class_grade;//课程学分
	private double class_score;//课程成绩
	private int level_id;
	private String score_level;
	private double score_point;//课程绩点
	private int getgrade;
	private String class_place;//课程地点
	private String class_weekday;//周几上课
	private int time_id;
	private String time_detail;//哪几节上课
	private int class_capacity;//课程最大人数
	private int currentquantity;//当前已选人数
	private int restquantity;//剩余可选人数
	private String teacher_id;//教师编号
	private String teacher_name;//教师姓名
	private int term_id;
	public String getClass_id() {
		return class_id;
	}
	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public int getClass_grade() {
		return class_grade;
	}
	public void setClass_grade(int class_grade) {
		this.class_grade = class_grade;
	}
	public double getClass_score() {
		return class_score;
	}
	public void setClass_score(double class_score) {
		this.class_score = class_score;
	}
	public int getLevel_id() {
		return level_id;
	}
	public void setLevel_id(int level_id) {
		this.level_id = level_id;
	}
	public String getScore_level() {
		return score_level;
	}
	public void setScore_level(String score_level) {
		this.score_level = score_level;
	}
	public double getScore_point() {
		return score_point;
	}
	public void setScore_point(double score_point) {
		this.score_point = score_point;
	}
	public int getGetgrade() {
		return getgrade;
	}
	public void setGetgrade(int getgrade) {
		this.getgrade = getgrade;
	}
	public String getClass_weekday() {
		return class_weekday;
	}
	public void setClass_weekday(String class_weekday) {
		this.class_weekday = class_weekday;
	}
	public int getTime_id() {
		return time_id;
	}
	public void setTime_id(int time_id) {
		this.time_id = time_id;
	}
	public String getTime_detail() {
		return time_detail;
	}
	public void setTime_detail(String time_detail) {
		this.time_detail = time_detail;
	}
	public String getClass_place() {
		return class_place;
	}
	public void setClass_place(String class_place) {
		this.class_place = class_place;
	}
	public int getClass_capacity() {
		return class_capacity;
	}
	public void setClass_capacity(int class_capacity) {
		this.class_capacity = class_capacity;
	}
	public int getCurrentquantity() {
		return currentquantity;
	}
	public void setCurrentquantity(int currentquantity) {
		this.currentquantity = currentquantity;
	}
	public int getRestquantity() {
		return restquantity;
	}
	public void setRestquantity(int restquantity) {
		this.restquantity = restquantity;
	}
	public String getTeacher_id() {
		return teacher_id;
	}
	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public int getTerm_id() {
		return term_id;
	}
	public void setTerm_id(int term_id) {
		this.term_id = term_id;
	}
}
