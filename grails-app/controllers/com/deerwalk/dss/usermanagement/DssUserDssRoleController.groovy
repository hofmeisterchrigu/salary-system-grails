package com.deerwalk.dss.usermanagement

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException
@Secured(['ROLE_SUPER_ADMIN'])
class DssUserDssRoleController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [dssUserDssRoleInstanceList: DssUserDssRole.list(params), dssUserDssRoleInstanceTotal: DssUserDssRole.count()]
    }

    def create() {
		switch (request.method) {
		case 'GET':
        	[dssUserDssRoleInstance: new DssUserDssRole(params)]
			break
		case 'POST':
	        def dssUserDssRoleInstance = new DssUserDssRole(params)
	        if (!dssUserDssRoleInstance.save(flush: true)) {
	            render view: 'create', model: [dssUserDssRoleInstance: dssUserDssRoleInstance]
	            return
	        }

			flash.message = message(code: 'default.created.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), dssUserDssRoleInstance.id])
	        redirect action: 'show', id: dssUserDssRoleInstance.id
			break
		}
    }

    def show() {
        def dssUserDssRoleInstance = DssUserDssRole.get(params.id)
        if (!dssUserDssRoleInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), params.id])
            redirect action: 'list'
            return
        }

        [dssUserDssRoleInstance: dssUserDssRoleInstance]
    }

    def edit() {
		switch (request.method) {
		case 'GET':
	        def dssUserDssRoleInstance = DssUserDssRole.get(params.id)
	        if (!dssUserDssRoleInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), params.id])
	            redirect action: 'list'
	            return
	        }

	        [dssUserDssRoleInstance: dssUserDssRoleInstance]
			break
		case 'POST':
	        def dssUserDssRoleInstance = DssUserDssRole.get(params.id)
	        if (!dssUserDssRoleInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), params.id])
	            redirect action: 'list'
	            return
	        }

	        if (params.version) {
	            def version = params.version.toLong()
	            if (dssUserDssRoleInstance.version > version) {
	                dssUserDssRoleInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
	                          [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole')] as Object[],
	                          "Another user has updated this DssUserDssRole while you were editing")
	                render view: 'edit', model: [dssUserDssRoleInstance: dssUserDssRoleInstance]
	                return
	            }
	        }

	        dssUserDssRoleInstance.properties = params

	        if (!dssUserDssRoleInstance.save(flush: true)) {
	            render view: 'edit', model: [dssUserDssRoleInstance: dssUserDssRoleInstance]
	            return
	        }

			flash.message = message(code: 'default.updated.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), dssUserDssRoleInstance.id])
	        redirect action: 'show', id: dssUserDssRoleInstance.id
			break
		}
    }

    def delete() {
        def dssUserDssRoleInstance = DssUserDssRole.get(params.id)
        if (!dssUserDssRoleInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), params.id])
            redirect action: 'list'
            return
        }

        try {
            dssUserDssRoleInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dssUserDssRole.label', default: 'DssUserDssRole'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
