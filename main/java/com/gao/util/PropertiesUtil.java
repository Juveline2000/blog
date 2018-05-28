package com.gao.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

//访问属性文件
public class PropertiesUtil {
	//通过key得到value
	public static String getValue(String key){
		Properties prop = new Properties();
		InputStream in= new PropertiesUtil().getClass().getResourceAsStream("/page.properties");
		try {
			prop.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop.getProperty(key);
	}
}
