package com.zh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zh.dao.TimeInfoDao;
import com.zh.vo.TimeInfo;

@Service("timeInfoService")
public class TimeInfoServiceImp implements TimeInfoService {
	@Resource
	private TimeInfoDao timeInfoDao;
	
	@Override
	public List<TimeInfo> queryAllTimeInfo() {
		// TODO Auto-generated method stub
		return timeInfoDao.queryAllTimeInfo();
	}
	
}
