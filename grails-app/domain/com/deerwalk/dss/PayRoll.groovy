package com.deerwalk.dss

class PayRoll {
	String formNumber
	String month
	String year;
	String description
	Float salary
	Boolean dashainBonus

	Date dateCreated
	Date lastUpdated

	static constraints = {
		formNumber(blank: false,nullable:false)
		year(blank: false,nullable:false)
		month(blank: false,nullable:false)
		description(blank: false,nullable:true)
		salary(blank: false,nullable:false)
		dashainBonus(blank: true,nullable:true)
	}
	String toString(){
		try{
			return Month.valueOf(month.toString()).getValue()+", "+year
		}catch (e){
			return month+" "+year
		}
	}
	static mapping = {
		formNumber  type:EncryptedString
		salary type:EncryptedFloat
	}
}
