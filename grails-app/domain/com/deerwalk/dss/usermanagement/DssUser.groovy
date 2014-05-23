package com.deerwalk.dss.usermanagement

class DssUser {

	transient springSecurityService
	String firstName
	String middleName
	String email
	String lastName
	String username
	String password
	boolean enabled=true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static constraints = {
		firstName blank: false
		middleName(blank: true,nullable: true)
		lastName blank: false
		email blank: false,unique: true
		username blank: false, unique: true
		password blank: true,nullable:true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<DssRole> getAuthorities() {
		DssUserDssRole.findAllByDssUser(this).collect { it.dssRole } as Set
	}

	def beforeInsert() {
		this.firstName=firstName?.capitalize()
		this.middleName=middleName?.capitalize()
		this.lastName=lastName?.capitalize()
		this.email=email?.toLowerCase()
		encodePassword()
	}

	def beforeUpdate() {
		this.firstName=firstName?.capitalize()
		this.middleName=middleName?.capitalize()
		this.lastName=lastName?.capitalize()
		this.email=email?.toLowerCase()
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}

	public String toString(){
		return firstName+" "+(middleName?middleName+' ':'')+lastName
	}
}
