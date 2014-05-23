package com.deerwalk.dss

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException
@Secured(['ROLE_USER'])
class PayRollDetailController {

	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']
	def calculateService
	def exportService
	def mailService

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[payRollDetailInstanceList: PayRollDetail.list(params), payRollDetailInstanceTotal: PayRollDetail.count()]
	}

	def create() {
		switch (request.method) {
			case 'GET':
				[payRollDetailInstance: new PayRollDetail(params)]
				break
			case 'POST':
				def payRollDetailInstance = new PayRollDetail(params)
				if (!payRollDetailInstance.save(flush: true)) {
					render view: 'create', model: [payRollDetailInstance: payRollDetailInstance]
					return
				}

				flash.message = message(code: 'default.created.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), payRollDetailInstance.id])
				redirect action: 'show', id: payRollDetailInstance.id
				break
		}
	}

	def show() {
		def payRollDetailInstance = PayRollDetail.get(params.id)
		if (!payRollDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), params.id])
			redirect action: 'list'
			return
		}

		[payRollDetailInstance: payRollDetailInstance]
	}

	def edit() {
		switch (request.method) {
			case 'GET':
				def payRollDetailInstance = PayRollDetail.get(params.id)
				if (!payRollDetailInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), params.id])
					redirect action: 'list'
					return
				}

				[payRollDetailInstance: payRollDetailInstance]
				break
			case 'POST':
				def payRollDetailInstance = PayRollDetail.get(params.id)
				if (!payRollDetailInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), params.id])
					redirect action: 'list'
					return
				}

				if (params.version) {
					def version = params.version.toLong()
					if (payRollDetailInstance.version > version) {
						payRollDetailInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
							[message(code: 'payRollDetail.label', default: 'PayRollDetail')] as Object[],
							"Another user has updated this PayRollDetail while you were editing")
						render view: 'edit', model: [payRollDetailInstance: payRollDetailInstance]
						return
					}
				}

				payRollDetailInstance.properties = params

				if (!payRollDetailInstance.save(flush: true)) {
					render view: 'edit', model: [payRollDetailInstance: payRollDetailInstance]
					return
				}

				flash.message = message(code: 'default.updated.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), payRollDetailInstance.id])
				redirect action: 'calculateTaxes', id: payRollDetailInstance.id
				break
		}
	}

	def delete() {
		def payRollDetailInstance = PayRollDetail.get(params.id)
		if (!payRollDetailInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), params.id])
			redirect action: 'list'
			return
		}

		try {
			payRollDetailInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), params.id])
			redirect action: 'list'
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'payRollDetail.label', default: 'PayRollDetail'), params.id])
			redirect action: 'show', id: params.id
		}
	}

	def calculateTaxes(){
		def payRollDetail = PayRollDetail.get(params.id)
		if (payRollDetail){
			def taxAmount = calculateService.calculateTaxForAnEmployee(payRollDetail.employee)
			payRollDetail.socialSecurityTax = taxAmount[0].toFloat().round(2)
			payRollDetail.incomeTax = taxAmount[1].toFloat().round(2)
			payRollDetail.save(flush: true)
		}
		flash.message = 'Taxes has been successfully calculated'
		redirect action: 'show', id: payRollDetail.id
	}

	def generateSalaryStatement(){
		def payRollDetail = PayRollDetail.get(params.id)
		if (payRollDetail){
			calculateService.generateReportAndSendEmail(payRollDetail.employee, payRollDetail, payRollDetail.payRoll)
		}
		flash.message = 'Salary Statement has been successfully sent'
		redirect action: 'list'
	}

	def search(){
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
        println params.search
		if(params.search){
			Employee employee=Employee.findByEmailOrEmployeeFirstName(params.search,params.search)
            println employee
			if(employee){
                def payRolls= PayRollDetail.findAllByEmployee(employee, params)
				flash.message="Search result."
				render(view: "list",model: [payRollDetailInstanceList: payRolls, payRollDetailInstanceTotal: PayRollDetail.count()])
				return;
			}
		}
		flash.message="No search result found."
		redirect(action: "list")
	}
}
