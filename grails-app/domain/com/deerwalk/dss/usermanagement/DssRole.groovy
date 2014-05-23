package com.deerwalk.dss.usermanagement

class DssRole {

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}

	public String toString(){
		return authority
	}
}
