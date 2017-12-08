package com.zh.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Repository;
@Repository
public class DateUtil {
	private static String str;
	public static String dateFormat(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		str = sdf.format(date);
		return str;
	}
	public static int getYear(Date date) {
		str = dateFormat(date);
		return Integer.parseInt(str.split("-")[0]);
	}
	public static int getMonth(Date date) {
		str = dateFormat(date);
		return Integer.parseInt(str.split("-")[1]);
	}
	public static int getDay(Date date) {
		str = dateFormat(date);
		return Integer.parseInt(str.split("-")[2]);
	}
}
