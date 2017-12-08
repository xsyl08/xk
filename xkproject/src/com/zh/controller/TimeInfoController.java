package com.zh.controller;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.service.TimeInfoService;
import com.zh.vo.TimeInfo;

@RequestMapping("/timeInfoController")
@Controller
public class TimeInfoController {
	@Resource
	private TimeInfoService timeInfoService;
	
	@RequestMapping("/queryAllTimeInfo")
	@ResponseBody
	public List<TimeInfo> queryAllTimeInfo(){
		return timeInfoService.queryAllTimeInfo();
	}
}
