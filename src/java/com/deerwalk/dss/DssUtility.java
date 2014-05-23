package com.deerwalk.dss;
import java.util.Random;

/**
 * Created with IntelliJ IDEA.
 * User: deerwalk
 * Date: 9/17/13
 * Time: 6:49 PM
 * To change this template use File | Settings | File Templates.
 */
public class DssUtility {
	public static final int MIN_LENGTH = 10;
	protected static Random r = new Random();
	protected static char[] passwordChar = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r',
		's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'P',
		'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '@', };

	public static long generateFileName() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < MIN_LENGTH; i++) {
			sb.append(r.nextInt(10));
		}
		return Long.parseLong(sb.toString());
	}

	public static String generatePassword() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < MIN_LENGTH; i++) {
			sb.append(passwordChar[r.nextInt(passwordChar.length)]);
		}
		return sb.toString();
	}
	public static String capitalizeString(String string) {
		char[] chars = string.toLowerCase().toCharArray();
		boolean found = false;
		for (int i = 0; i < chars.length; i++) {
			if (!found && Character.isLetter(chars[i])) {
				chars[i] = Character.toUpperCase(chars[i]);
				found = true;
			} else if (Character.isWhitespace(chars[i]) || chars[i]=='.' || chars[i]=='\'') { // You can add other chars here
				found = false;
			}
		}
		return String.valueOf(chars);
	}
}
