import com.deerwalk.dss.SalaryConfiguration
import com.deerwalk.dss.usermanagement.DssRole
import com.deerwalk.dss.usermanagement.DssUser
import com.deerwalk.dss.usermanagement.DssUserDssRole

class BootStrap {

	def init = { servletContext ->
		def roleList=DssRole.findAll();
		def adminRole
		if(!roleList){
			adminRole = new DssRole(authority: 'ROLE_ADMIN').save(flush: true)
			def userRole = new DssRole(authority: 'ROLE_USER').save(flush: true)

		}else{
			adminRole=roleList.find {it.authority='ROLE_ADMIN'}
		}
		def userList=DssUser.findAll()
		if(!userList){
			def testUser = new DssUser(username: 'me', enabled: true, password: 'password', firstName: 'Test', middleName: 'M', lastName: 'User', email: 'test@user.com')
			testUser.save(flush: true)

			DssUserDssRole.create(testUser,adminRole,true)

		}

		new SalaryConfiguration(particular:'marriedOnePercentTaxAmount', particularValue: 250000).save(flush: true)
		new SalaryConfiguration(particular:'unMarriedOnePercentTaxAmount', particularValue: 200000).save(flush: true)
		new SalaryConfiguration(particular:'insuranceAmount', particularValue: 20000).save(flush: true)
		new SalaryConfiguration(particular:'fifteenPercentTaxMargin', particularValue: 100000).save(flush: true)
		new SalaryConfiguration(particular:'taxMonth', particularValue: 8).save(flush: true)
		new SalaryConfiguration(particular:'femaleDiscountPercent', particularValue: 5).save(flush: true)

		println '  /$$$$$$            /$$                                      /$$$$$$                        /$$                            \n' +
			' /$$__  $$          | $$                                     /$$__  $$                      | $$                            \n' +
			'| $$  \\__/  /$$$$$$ | $$  /$$$$$$   /$$$$$$  /$$   /$$      | $$  \\__/ /$$   /$$  /$$$$$$$ /$$$$$$    /$$$$$$  /$$$$$$/$$$$ \n' +
			'|  $$$$$$  |____  $$| $$ |____  $$ /$$__  $$| $$  | $$      |  $$$$$$ | $$  | $$ /$$_____/|_  $$_/   /$$__  $$| $$_  $$_  $$\n' +
			' \\____  $$  /$$$$$$$| $$  /$$$$$$$| $$  \\__/| $$  | $$       \\____  $$| $$  | $$|  $$$$$$   | $$    | $$$$$$$$| $$ \\ $$ \\ $$\n' +
			' /$$  \\ $$ /$$__  $$| $$ /$$__  $$| $$      | $$  | $$       /$$  \\ $$| $$  | $$ \\____  $$  | $$ /$$| $$_____/| $$ | $$ | $$\n' +
			'|  $$$$$$/|  $$$$$$$| $$|  $$$$$$$| $$      |  $$$$$$$      |  $$$$$$/|  $$$$$$$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$ | $$ | $$\n' +
			' \\______/  \\_______/|__/ \\_______/|__/       \\____  $$       \\______/  \\____  $$|_______/    \\___/   \\_______/|__/ |__/ |__/\n' +
			'                                             /$$  | $$                 /$$  | $$                                            \n' +
			'                                            |  $$$$$$/                |  $$$$$$/                                            \n' +
			'                                             \\______/                  \\______/                                             \n' +
			''

	}
	def destroy = {
	}
}
