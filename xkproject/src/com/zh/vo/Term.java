package com.zh.vo;

import java.util.Date;

public class Term {
	private int term_id;
	private String term_name;
	private Date begin_date;
	private Date end_date;
	public int getTerm_id() {
		return term_id;
	}
	public void setTerm_id(int term_id) {
		this.term_id = term_id;
	}
	public String getTerm_name() {
		return term_name;
	}
	public void setTerm_name(String term_name) {
		this.term_name = term_name;
	}
	public Date getBegin_date() {
		return begin_date;
	}
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
}
