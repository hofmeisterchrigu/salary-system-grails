package com.deerwalk.dss

class PayRollDetail {

	Employee employee
	PayRoll payRoll
	Float basicSalary
	Float providentFund
	Float cit
	Float socialSecurityTax
	Float incomeTax
	Float dashainBonus
	Float foodDeduction
	Float bonus
	Boolean isMailSent=false
	Float advanceSalary=0.0 as Float
	Date dateCreated
	Date lastUpdated

	static constraints = {
		employee(nullable: false, blank:false,unique:['payRoll'])
		payRoll(nullable: false, blank:false)
		basicSalary(nullable: false, blank:false)
		providentFund(nullable: true, blank:true)
		cit(nullable: true, blank:true)
		socialSecurityTax(nullable: true, blank:true)
		incomeTax(nullable: true, blank:true)
		dashainBonus(nullable: true, blank:true)
		foodDeduction(nullable: true, blank:true)
		bonus(nullable: true, blank:true)
		advanceSalary(blank: true,nullable:true)
		isMailSent(blank: true,nullable:true)
	}

	static mapping = {
		basicSalary  type:EncryptedFloat
		providentFund  type:EncryptedFloat
		cit  type:EncryptedFloat
		socialSecurityTax  type:EncryptedFloat
		incomeTax  type:EncryptedFloat
		dashainBonus type:EncryptedFloat
		bonus type:EncryptedFloat
		advanceSalary type:EncryptedFloat
	}
}
