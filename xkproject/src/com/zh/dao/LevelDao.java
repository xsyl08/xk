package com.zh.dao;

import org.apache.ibatis.annotations.Param;

import com.zh.vo.Level;

public interface LevelDao {
	public Level queryLevelByClassScore(@Param("class_score") double class_score);
}
