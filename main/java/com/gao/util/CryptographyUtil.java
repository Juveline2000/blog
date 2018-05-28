package com.gao.util;

import org.apache.shiro.codec.Base64;
import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * ���ܹ���
 * @author Administrator
 *
 */
public class CryptographyUtil {

	/**
	 * base64����
	 * @return 
	 * */
	public static String encBase64(String str){
		return Base64.encodeToString(str.getBytes());
	}
	
	/**
	 * base64����
	 * */
	public static String decBase64(String str){
		return Base64.decodeToString(str);
	}
	
	/**
	 * Md5����,ֻ��md5������md5������ײ�õ�,����salt�Ͳ�����ת
	 * @param str
	 * @param salt
	 * @return
	 */
	public static String md5(String str,String salt){
		return new Md5Hash(str,salt).toString();
	}
	
	public static void main(String[] args) {
		String password="1";
		System.out.println("base64����:"+CryptographyUtil.encBase64(password));
		System.out.println("base64����:"+CryptographyUtil.decBase64(CryptographyUtil.encBase64(password)));
		
		System.out.println("Md5���ܣ�"+CryptographyUtil.md5(password, "gao"));//�����ļ���
	}
}
