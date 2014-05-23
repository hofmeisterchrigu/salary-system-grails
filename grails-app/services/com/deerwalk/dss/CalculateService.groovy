package com.deerwalk.dss

import org.codehaus.groovy.grails.commons.ApplicationHolder

class CalculateService {
	static transactional = false
	def exportService
	def mailService
	def root = ApplicationHolder.getApplication().getMainContext().getResource("/").getFile().getAbsolutePath()
	/*def serviceMethod() {

	}*/

	def calculateTaxForAnEmployee(employee){
		def onePercentTaxAmount = 0
		if (employee.isMarried){
			onePercentTaxAmount = SalaryConfiguration.findByParticular('marriedOnePercentTaxAmount')?.particularValue?.toInteger()
		}else{
			onePercentTaxAmount = SalaryConfiguration.findByParticular('unMarriedOnePercentTaxAmount')?.particularValue?.toInteger()
		}

		def maxEmployeeInsurance = SalaryConfiguration.findByParticular('insuranceAmount')?.particularValue?.toInteger()

		def insuranceAmount = 0
		def taxableAmountList = calculateTaxableAmount(employee)

		def taxableAmount = taxableAmountList[0] + taxableAmountList[1]
		def taxedMonth = taxableAmountList[4]
		def taxedSocialSecurityAmount = taxableAmountList[2]
		def taxedIncomeAmount = taxableAmountList[3]

		if (employee.insuranceAmount){
			if (employee.insuranceAmount>=maxEmployeeInsurance){
				insuranceAmount = maxEmployeeInsurance
			}else{
				insuranceAmount = employee.insuranceAmount
			}
		}

		def totalTaxableAmount = taxableAmount - insuranceAmount

		def fifteenPercentTaxMargin = SalaryConfiguration.findByParticular('fifteenPercentTaxMargin')?.particularValue?.toInteger()

		def taxTotal25Percentage = 0
		def taxTotal15Percentage = 0
		def taxTotal1Percentage = 0

		if(totalTaxableAmount > (onePercentTaxAmount+fifteenPercentTaxMargin)){
			taxTotal25Percentage = (totalTaxableAmount-(onePercentTaxAmount+fifteenPercentTaxMargin))*(0.25);
			taxTotal15Percentage = fifteenPercentTaxMargin*0.15;
			taxTotal1Percentage = onePercentTaxAmount*0.01;
		}else if(totalTaxableAmount >= onePercentTaxAmount){
			taxTotal15Percentage = (totalTaxableAmount-onePercentTaxAmount)*(0.15);
			taxTotal1Percentage = onePercentTaxAmount*0.01;
		}else{
			taxTotal1Percentage = totalTaxableAmount*0.01;
		}

		def otherPerMonthTax = (taxTotal15Percentage + taxTotal25Percentage - taxedIncomeAmount) / (12-taxedMonth);
		def perOnePerMonthTax = (taxTotal1Percentage-taxedSocialSecurityAmount)/(12-taxedMonth);

		if(otherPerMonthTax<0){
			otherPerMonthTax = 0
		}

		def femaleDiscountPercent = SalaryConfiguration.findByParticular('femaleDiscountPercent')?.particularValue?.toInteger()

		if(employee.gender=="f"){
			if(otherPerMonthTax>0){
				def discountOnePerMonthTax = perOnePerMonthTax * femaleDiscountPercent / 100;
				otherPerMonthTax = otherPerMonthTax - discountOnePerMonthTax;
			}else{
				perOnePerMonthTax = (perOnePerMonthTax-perOnePerMonthTax * femaleDiscountPercent / 100);
			}
		}

		return [perOnePerMonthTax,otherPerMonthTax]
	}

	def calculateTaxableAmount(employee){
		def payRollDetailOfEmployee = PayRollDetail.findAllByEmployee(employee)
		def taxMonth = SalaryConfiguration.findByParticular('taxMonth')?.particularValue?.toInteger()

		def taxableDate = new Date();
		def todayDate = new Date();
		if (todayDate.getMonth()<(taxMonth.toInteger()-1)){
			taxableDate.setYear(taxableDate.getYear()-1)
		}
		taxableDate.setMonth(taxMonth.toInteger()-1)
		taxableDate.setDate(1)

		def totalMonth = getMonthsDifference(taxableDate, todayDate)
		def totalIncomeTaxPaid = 0
		def totalSocialSecurityTaxPaid = 0
		def totalTaxableAmount = 0
		def changedTotalMonth = 0
		payRollDetailOfEmployee.each{detail->
			def date = Date.parse("MMM-yyyy",detail.payRoll.month+'-'+detail.payRoll.year)
			if (date>=taxableDate){
				totalIncomeTaxPaid = totalIncomeTaxPaid + (detail.incomeTax? detail.incomeTax:0)
				totalSocialSecurityTaxPaid = totalSocialSecurityTaxPaid + (detail.socialSecurityTax?detail.socialSecurityTax:0)
				totalTaxableAmount = totalTaxableAmount + (detail.basicSalary + (detail.bonus?detail.bonus:0) + (detail.dashainBonus?detail.dashainBonus:0) - ((detail.cit?detail.cit:0) + (detail.providentFund?detail.providentFund:0)/2))
				changedTotalMonth++
			}
		}
		if(changedTotalMonth>totalMonth){
			totalMonth = changedTotalMonth
		}
		def newTotalMonth = totalMonth
		def totalTaxableAmountComing = 0
		for(newTotalMonth;newTotalMonth<12;newTotalMonth++){
			def providentFund = 0
			if (employee.willGetPf){providentFund = employee.basicScaleAmount * 0.10}
			def cit = employee.basicScaleAmount * employee.citPercentage /100
			totalTaxableAmountComing = totalTaxableAmountComing + employee.basicScaleAmount - (providentFund  + cit)
		}
		return [totalTaxableAmount,totalTaxableAmountComing,totalSocialSecurityTaxPaid,totalIncomeTaxPaid,totalMonth]

	}

	def getMonthsDifference(Date date1, Date date2) {
		int m1 = date1.getYear() * 12 + date1.getMonth();
		int m2 = date2.getYear() * 12 + date2.getMonth();
		return m2 - m1;
	}

	def generateReportAndSendEmail(Employee employee, PayRollDetail payRollDetail, PayRoll payRoll) {
		def columns = [
			'name':'Name of Employee',
			'maritalStatus':'Marital Status',
			'basicSalary':'Basic Salary',
			'accuredSalary':"Accured Salary for ${payRoll.month}",
			'performanceBonus':'Performance Bonus',
			'pfFromOffice':'PF from Company @ 10%',
			'grossSalary':'Gross Salary',
			'citPercent':'CIT %',
			'pfDeposited':"PF Deposited @ 20% for ${payRoll.month}",
			'citDeposited':"CIT Deposited for ${payRoll.month}",
			'totalTax':"TDS Deducted for ${payRoll.month}",
			'foodDeduction':'Food Deduction',
			'advanceSalary':'Advance Salary',
			'netPayable':'Net Salary Payable',
			'accountNumber':'Bank A/C Number'
		]
		def data = [:]
		def empName = employee.employeeFirstName
		employee.employeeMiddleName? (empName + " ${employee.employeeMiddleName}"):""
		empName = empName + " ${employee.employeeLastName}"
		data.put('name',empName)
		data.put('maritalStatus',employee.isMarried?"Married":"Single")
		data.put('basicSalary',employee.basicScaleAmount)
		data.put('accuredSalary',payRollDetail.basicSalary)
		data.put('performanceBonus',payRollDetail.bonus)
		def pfFromOffice = 0
		if(employee.willGetPf){
			pfFromOffice = payRollDetail.basicSalary*0.1

		}
		data.put('pfFromOffice',pfFromOffice)
		data.put('grossSalary',payRollDetail.basicSalary+pfFromOffice)
		data.put('citPercent',employee.citPercentage)
		data.put('pfDeposited',payRollDetail.providentFund)
		data.put('citDeposited',payRollDetail.cit)
		data.put('totalTax',payRollDetail.socialSecurityTax+payRollDetail.incomeTax)
		data.put('foodDeduction',payRollDetail.foodDeduction)
		data.put('advanceSalary',payRollDetail.advanceSalary)
		def netPayable = payRollDetail.basicSalary + payRollDetail.bonus - (payRollDetail.providentFund + payRollDetail.cit + payRollDetail.socialSecurityTax + payRollDetail.incomeTax + payRollDetail.foodDeduction + payRollDetail.advanceSalary)
		data.put('netPayable',netPayable)
		data.put('accountNumber',employee.bankAccountNumber)

		List fields = columns.keySet().toList()
		def fileName = "SalaryStatement_${empName}.xls"
		File salarySheet = new File(root+'/Statements',fileName);
		FileOutputStream out=new FileOutputStream(salarySheet)
		exportService.export('excel', out, [data], fields, columns, [:], [:])
		out.flush()
		out.close()

		try{
			mailService.sendMail {
				multipart true
				to employee.email
				subject "Salary Statement"
				html "Hello,<br/><br/>Please find the attachment of salary slip for the month of ${payRoll.month}. If you have any query regarding this, please do let us know.<br/><br/>Thanks, <br/>Account Department"
				attachBytes fileName, "text/excel", salarySheet.readBytes()
			}
			payRollDetail.isMailSent = true
			payRollDetail.save(flush: true)
		}catch(e){
			e.printStackTrace()
		}
		salarySheet.delete()
	}
}
