package com.zh.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CheckCodeController {
	/**
	 * 检查输入的验证码是否正确
	 * @param req
	 * @param imageCode
	 * @return
	 */
	@RequestMapping("/checkCode")
	@ResponseBody
	public String checkCode(HttpServletRequest req,@Param("imageCode") String imageCode) {
		if(req.getSession().getAttribute("sRand").equals(imageCode)) {
			return "OK";
		}
		return "ERROR";
	}
}
