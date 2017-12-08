package com.zh.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zh.dao.LevelDao;
import com.zh.vo.Level;

@Service("levelService")
public class LevelServiceImp implements LevelService {
	@Resource
	private LevelDao levelDao;

	@Override
	public Level queryLevelByClassScore(double class_score) {
		// TODO Auto-generated method stub
		return levelDao.queryLevelByClassScore(class_score);
	}

}
