package com.deerwalk.dss

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException
@Secured(['ROLE_USER'])
class PayRollController {

	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']
	def calculateService

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[payRollInstanceList: PayRoll.list(params), payRollInstanceTotal: PayRoll.count()]
	}

	def create() {
		switch (request.method) {
			case 'GET':
				[payRollInstance: new PayRoll(params)]
				break
			case 'POST':
				def payRollInstance = new PayRoll(params)
				if (!payRollInstance.save(flush: true)) {
					render view: 'create', model: [payRollInstance: payRollInstance]
					return
				}

				flash.message = message(code: 'default.created.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), payRollInstance.id])
				redirect action: 'show', id: payRollInstance.id
				break
		}
	}

	def show() {
		def payRollInstance = PayRoll.get(params.id)
		if (!payRollInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), params.id])
			redirect action: 'list'
			return
		}

		[payRollInstance: payRollInstance]
	}

	def edit() {
		switch (request.method) {
			case 'GET':
				def payRollInstance = PayRoll.get(params.id)
				if (!payRollInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), params.id])
					redirect action: 'list'
					return
				}

				[payRollInstance: payRollInstance]
				break
			case 'POST':
				def payRollInstance = PayRoll.get(params.id)
				if (!payRollInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), params.id])
					redirect action: 'list'
					return
				}

				if (params.version) {
					def version = params.version.toLong()
					if (payRollInstance.version > version) {
						payRollInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
							[message(code: 'payRoll.label', default: 'PayRoll')] as Object[],
							"Another user has updated this PayRoll while you were editing")
						render view: 'edit', model: [payRollInstance: payRollInstance]
						return
					}
				}

				payRollInstance.properties = params

				if (!payRollInstance.save(flush: true)) {
					render view: 'edit', model: [payRollInstance: payRollInstance]
					return
				}

				flash.message = message(code: 'default.updated.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), payRollInstance.id])
				redirect action: 'show', id: payRollInstance.id
				break
		}
	}

	def delete() {
		def payRollInstance = PayRoll.get(params.id)
		if (!payRollInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), params.id])
			redirect action: 'list'
			return
		}

		try {
			payRollInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), params.id])
			redirect action: 'list'
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'payRoll.label', default: 'PayRoll'), params.id])
			redirect action: 'show', id: params.id
		}
	}

	def generatePayRollDetails() {
		def payRoll = PayRoll.get(params.id)
		def employeeList = Employee.getAll()
		if (employeeList.size() != PayRollDetail.findAllByPayRoll(payRoll)){
			employeeList.each{employee ->
				if (!PayRollDetail.findAllByPayRollAndEmployee(payRoll,employee)){
					def providentFund = 0
					if (employee.willGetPf){providentFund = (employee.basicScaleAmount * 0.10 * 2).round(2)}
					def cit = (employee.basicScaleAmount * employee.citPercentage /100).round(2)
					def socialSecurityTax = 0
					def incomeTax = 0
					def dashainBonus = 0
					if(payRoll.dashainBonus){
						dashainBonus = employee.basicScaleAmount
					}
					def foodDeduction = 0
					def bonus = 0
					new PayRollDetail(employee:employee,payRoll:payRoll,basicSalary:employee.basicScaleAmount,providentFund: providentFund,cit:cit,socialSecurityTax:socialSecurityTax,incomeTax:incomeTax,dashainBonus:dashainBonus,foodDeduction:foodDeduction,bonus:bonus).save(flush: true)
				}
			}
		}
		flash.message = 'PayRoll Details for each employee has been successfully generated'
		redirect action: 'list'
	}

	def calculateTaxes(){
		def payRoll = PayRoll.get(params.id)
		def employeeList = Employee.getAll()
		employeeList.each{employee ->
			def payRollDetail = PayRollDetail.findByPayRollAndEmployee(payRoll,employee)
			if (payRollDetail){
				def taxAmount = calculateService.calculateTaxForAnEmployee(employee)
				payRollDetail.socialSecurityTax = taxAmount[0].toFloat().round(2)
				payRollDetail.incomeTax = taxAmount[1].toFloat().round(2)
				payRollDetail.save(flush: true)
			}
		}
		flash.message = 'Taxes has been successfully calculated'
		redirect action: 'list'
	}

	def generateSalaryStatement(){
		def payRoll = PayRoll.get(params.id)
		def employeeList = Employee.getAll()
		employeeList.each{employee ->
			def payRollDetail = PayRollDetail.findByPayRollAndEmployee(payRoll,employee)
			if (payRollDetail && !payRollDetail.isMailSent){
				calculateService.generateReportAndSendEmail(employee, payRollDetail, payRoll)
			}
		}
		flash.message = 'Salary Statement has been successfully sent'
		redirect action: 'list'
	}
}
