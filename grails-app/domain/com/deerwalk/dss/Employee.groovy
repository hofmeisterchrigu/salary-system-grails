package com.deerwalk.dss

import javax.persistence.Transient

class Employee {
	String uniqueEmployeeId
	String employeeFirstName
	String employeeMiddleName
	String employeeLastName
	String phoneNumber
	String designation
	Float basicScaleAmount
	String department
	String gender
	String email
	Boolean isMarried
	Boolean disability
	Boolean willGetDashainBonus
	Boolean willGetPf

	Float citPercentage=0.0 as Float
	String citNumber
	String providentFundNumber
	String panNumber
	String bankAccountNumber
	Float insuranceAmount
    @Transient
    String searchCrit;


	Date dateCreated
	Date lastUpdated

	static constraints = {
		uniqueEmployeeId(blank: false,nullable:false,unique: true)
		employeeFirstName(blank: false,nullable:false)
		employeeMiddleName(blank: true,nullable:true)
		employeeLastName(blank: false,nullable:false)
		phoneNumber(blank: true,nullable:true)
		designation(blank: false,nullable:false)
		gender(blank: false,nullable:false)
		email(blank: false,nullable:false,email:true)
		basicScaleAmount(blank: false,nullable:false)
		department(blank: false,nullable:false)
		isMarried(blank: true,nullable:true)
		disability(blank: true,nullable:true)
		panNumber(blank: true,nullable:true)
		bankAccountNumber(blank: true,nullable:true)
		citNumber(blank: true,nullable:true)
		providentFundNumber(blank: true,nullable:true)
		citPercentage(blank: true,nullable:true,max:33.0 as Float,min:0.0 as Float)
		insuranceAmount(blank: true,nullable:true)
		willGetDashainBonus(blank: true,nullable:true)
		willGetPf(blank: true,nullable:true)

		citPercentage validator: {val, obj->
			if(obj.willGetPf && obj.citPercentage){
				return val<=23
			}
		}
		citNumber validator: {val,obj ->
			if(obj.citPercentage>0){
				return val!=null
			}
			return true
		}
		providentFundNumber validator: {val,obj ->
			if(obj.willGetPf){
				return val!=null
			}
			return true
		}
	}

	String toString(){
		def name = employeeFirstName
		employeeMiddleName?( name = name+' '+employeeMiddleName):''
		name = name +' '+employeeLastName
		return name
	}
	static mapping = {
		uniqueEmployeeId type:EncryptedString
		employeeFirstName type:EncryptedString
		employeeMiddleName type:EncryptedString
		employeeLastName type:EncryptedString
		phoneNumber type:EncryptedString
		designation type:EncryptedString
		email type:EncryptedString
		basicScaleAmount type:EncryptedFloat
		panNumber type:EncryptedString
		bankAccountNumber type:EncryptedString
		citNumber type:EncryptedString
		providentFundNumber type:EncryptedString
	}
	def beforeInsert(){
		this.employeeFirstName=employeeFirstName?.capitalize()
		this.employeeMiddleName=employeeMiddleName?.capitalize()
		this.employeeLastName=employeeLastName?.capitalize()
		this.email=email?.toLowerCase()
	}
	def beforeUpdate(){
		this.employeeFirstName=employeeFirstName?.capitalize()
		this.employeeMiddleName=employeeMiddleName?.capitalize()
		this.employeeLastName=employeeLastName?.capitalize()
		this.email=email?.toLowerCase()
	}
    String getSearchCrit() {
        return this.toString()+", "+email
    }

    void setSearchCrit(String searchCrit) {
        this.searchCrit = this.toString()+", "+email
    }
}
