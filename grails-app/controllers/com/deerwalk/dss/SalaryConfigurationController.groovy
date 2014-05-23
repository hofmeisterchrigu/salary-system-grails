package com.deerwalk.dss

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException
@Secured(['ROLE_USER'])
class SalaryConfigurationController {

	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[salaryConfigurationInstanceList: SalaryConfiguration.list(params), salaryConfigurationInstanceTotal: SalaryConfiguration.count()]
	}

	def create() {
		switch (request.method) {
			case 'GET':
				[salaryConfigurationInstance: new SalaryConfiguration(params)]
				break
			case 'POST':
				def salaryConfigurationInstance = new SalaryConfiguration(params)
				if (!salaryConfigurationInstance.save(flush: true)) {
					render view: 'create', model: [salaryConfigurationInstance: salaryConfigurationInstance]
					return
				}

				flash.message = message(code: 'default.created.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), salaryConfigurationInstance.id])
				redirect action: 'show', id: salaryConfigurationInstance.id
				break
		}
	}

	def show() {
		def salaryConfigurationInstance = SalaryConfiguration.get(params.id)
		if (!salaryConfigurationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), params.id])
			redirect action: 'list'
			return
		}

		[salaryConfigurationInstance: salaryConfigurationInstance]
	}

	def edit() {
		switch (request.method) {
			case 'GET':
				def salaryConfigurationInstance = SalaryConfiguration.get(params.id)
				if (!salaryConfigurationInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), params.id])
					redirect action: 'list'
					return
				}

				[salaryConfigurationInstance: salaryConfigurationInstance]
				break
			case 'POST':
				def salaryConfigurationInstance = SalaryConfiguration.get(params.id)
				if (!salaryConfigurationInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), params.id])
					redirect action: 'list'
					return
				}

				if (params.version) {
					def version = params.version.toLong()
					if (salaryConfigurationInstance.version > version) {
						salaryConfigurationInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
							[message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration')] as Object[],
							"Another user has updated this SalaryConfiguration while you were editing")
						render view: 'edit', model: [salaryConfigurationInstance: salaryConfigurationInstance]
						return
					}
				}

				salaryConfigurationInstance.properties = params

				if (!salaryConfigurationInstance.save(flush: true)) {
					render view: 'edit', model: [salaryConfigurationInstance: salaryConfigurationInstance]
					return
				}

				flash.message = message(code: 'default.updated.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), salaryConfigurationInstance.id])
				redirect action: 'show', id: salaryConfigurationInstance.id
				break
		}
	}

	def delete() {
		def salaryConfigurationInstance = SalaryConfiguration.get(params.id)
		if (!salaryConfigurationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), params.id])
			redirect action: 'list'
			return
		}

		try {
			salaryConfigurationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), params.id])
			redirect action: 'list'
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'salaryConfiguration.label', default: 'SalaryConfiguration'), params.id])
			redirect action: 'show', id: params.id
		}
	}
}
