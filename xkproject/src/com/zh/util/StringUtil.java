package com.zh.util;

import java.util.ArrayList;
import java.util.List;

public class StringUtil {
	public static List<Integer> getArray(String string) {
		String str = string.substring(1,string.length()-1);
		List<Integer> il = new ArrayList<>();
		for(String s:str.split(",")) {
			il.add(Integer.parseInt(s));
		}
		return il;
	}
	public static boolean haveSameElement(String string1,String string2) {
		boolean flag = false;
		List<Integer> il_1 = getArray(string1);
		List<Integer> il_2 = getArray(string2);
		for(int i:il_1) {
			if(il_2.contains(i)) {
				flag = true;
				break;
			}
		}
		return flag;
	}
//	public static void main(String[] args) {
//		System.out.println(haveSameElement("第1,2节","第1,2,3节"));
//	}
}
