package com.deerwalk.dss.usermanagement

import com.deerwalk.dss.DssUtility
import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException
@Secured(['ROLE_ADMIN'])
class DssUserController {
	def mailService
	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[dssUserInstanceList: DssUser.list(params), dssUserInstanceTotal: DssUser.count()]
	}

	def create() {
		switch (request.method) {
			case 'GET':
				[dssUserInstance: new DssUser(params)]
				break
			case 'POST':
				DssUser dssUserInstance = new DssUser(params)
				def randomPassword= DssUtility.generatePassword()
				dssUserInstance.password=randomPassword;
				Integer roleId=Integer.parseInt(params.role)
				DssRole role=DssRole.findById(roleId)
				if (!dssUserInstance.save(flush: true) || !role) {
					render view: 'create', model: [dssUserInstance: dssUserInstance]
					return
				}
				DssUserDssRole.create(dssUserInstance,role,true)
				try{
					mailService.sendMail {
						to dssUserInstance.email
						subject "Account created"
						html "Hello,<br/><br/>Your profile has been created successfully." +
							" Please find your credentials for Deerwalk Salary System:" +
							" <br> Username :<b> ${dssUserInstance.username}</b>" +
							"<br> Password :<b> ${randomPassword}</b>. <br><br>" +
							"If you have any query regarding this, please do let us know.<br/><br/>Thanks"
					}
				}catch(e){
					e.printStackTrace()
				}
				flash.message = message(code: 'default.created.message', args: [message(code: 'dssUser.label', default: 'DssUser'), dssUserInstance.id])
				redirect action: 'show', id: dssUserInstance.id
				break
		}
	}

	def show() {
		def dssUserInstance = DssUser.get(params.id)
		if (!dssUserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUser.label', default: 'DssUser'), params.id])
			redirect action: 'list'
			return
		}

		[dssUserInstance: dssUserInstance]
	}

	def edit() {
		switch (request.method) {
			case 'GET':
				def dssUserInstance = DssUser.get(params.id)
				if (!dssUserInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUser.label', default: 'DssUser'), params.id])
					redirect action: 'list'
					return
				}

				[dssUserInstance: dssUserInstance]
				break
			case 'POST':
				def dssUserInstance = DssUser.get(params.id)
				if (!dssUserInstance) {
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUser.label', default: 'DssUser'), params.id])
					redirect action: 'list'
					return
				}

				if (params.version) {
					def version = params.version.toLong()
					if (dssUserInstance.version > version) {
						dssUserInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
							[message(code: 'dssUser.label', default: 'DssUser')] as Object[],
							"Another user has updated this DssUser while you were editing")
						render view: 'edit', model: [dssUserInstance: dssUserInstance]
						return
					}
				}

				dssUserInstance.properties = params

				if (!dssUserInstance.save(flush: true)) {
					render view: 'edit', model: [dssUserInstance: dssUserInstance]
					return
				}

				flash.message = message(code: 'default.updated.message', args: [message(code: 'dssUser.label', default: 'DssUser'), dssUserInstance.id])
				redirect action: 'show', id: dssUserInstance.id
				break
		}
	}

	def delete() {
		def dssUserInstance = DssUser.get(params.id)
		if (!dssUserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUser.label', default: 'DssUser'), params.id])
			redirect action: 'list'
			return
		}

		try {
			dssUserInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'dssUser.label', default: 'DssUser'), params.id])
			redirect action: 'list'
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dssUser.label', default: 'DssUser'), params.id])
			redirect action: 'show', id: params.id
		}
	}

	def resetPassword(){
		DssUser dssUserInstance = DssUser.findById(params.id)
		def randomPassword= DssUtility.generatePassword()
		dssUserInstance.password=randomPassword;
		if (!dssUserInstance.save(flush: true)) {
			flash.message = "Fail to update user."
			redirect action: 'show', id: dssUserInstance.id
			return
		}
		try{
			mailService.sendMail {
				to dssUserInstance.email
				subject "Your new password"
				html "Hello,<br/><br/>Your profile has been created successfully." +
					" Please find your new credentials for Deerwalk Salary System:" +
					" <br> Username :<b> ${dssUserInstance.username}</b>" +
					"<br>New Password :<b> ${randomPassword}</b>. <br><br>" +
					"If you have any query regarding this, please do let us know.<br/><br/>Thanks"
			}
		}catch(e){
			e.printStackTrace()
		}
		flash.message = message(code: 'default.updated.message', args: [message(code: 'dssUser.label', default: 'DssUser'), dssUserInstance.id])
		redirect action: 'show', id: dssUserInstance.id
	}
}
