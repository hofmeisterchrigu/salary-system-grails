package dss

class DssTagLib {
	static namespace = "dss"
	def springSecurityService
	def fullName = { attrs ->
		if (springSecurityService.isLoggedIn()) {
			out << springSecurityService.currentUser.encodeAsHTML()
		}
	}
}
