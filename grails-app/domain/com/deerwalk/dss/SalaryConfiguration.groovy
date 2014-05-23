package com.deerwalk.dss

class SalaryConfiguration {
	String particular
	String particularValue
	String type

	Date dateCreated
	Date lastUpdated

	static constraints = {
		particular(blank: true,nullable:true, unique: true)
		particularValue(blank: true,nullable:true)
		type(blank: true,nullable:true)
	}
}
