package com.deerwalk.dss

/**
 * Created with IntelliJ IDEA.
 * User: deerwalk
 * Date: 9/9/13
 * Time: 6:47 PM
 * To change this template use File | Settings | File Templates.
 */
public enum Gender {
	M('Male'),F('Female');
	String value;

	Gender(String value){
		this.value=value;
	}
	String getValue(){value}
}
