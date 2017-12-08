package com.zh.vo;

public class Level {
	private int level_id;
	private double class_score;
	private double low_score;
	private double high_score;
	private String score_level;
	public int getLevel_id() {
		return level_id;
	}
	public void setLevel_id(int level_id) {
		this.level_id = level_id;
	}
	public double getClass_score() {
		return class_score;
	}
	public void setClass_score(double class_score) {
		this.class_score = class_score;
	}
	public double getLow_score() {
		return low_score;
	}
	public void setLow_score(double low_score) {
		this.low_score = low_score;
	}
	public double getHigh_score() {
		return high_score;
	}
	public void setHigh_score(double high_score) {
		this.high_score = high_score;
	}
	public String getScore_level() {
		return score_level;
	}
	public void setScore_level(String score_level) {
		this.score_level = score_level;
	}
}
