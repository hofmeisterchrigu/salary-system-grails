package com.deerwalk.dss.usermanagement

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException
@Secured(['ROLE_SUPER_ADMIN'])
class DssRoleController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [dssRoleInstanceList: DssRole.list(params), dssRoleInstanceTotal: DssRole.count()]
    }

    def create() {
		switch (request.method) {
		case 'GET':
        	[dssRoleInstance: new DssRole(params)]
			break
		case 'POST':
	        def dssRoleInstance = new DssRole(params)
	        if (!dssRoleInstance.save(flush: true)) {
	            render view: 'create', model: [dssRoleInstance: dssRoleInstance]
	            return
	        }

			flash.message = message(code: 'default.created.message', args: [message(code: 'dssRole.label', default: 'DssRole'), dssRoleInstance.id])
	        redirect action: 'show', id: dssRoleInstance.id
			break
		}
    }

    def show() {
        def dssRoleInstance = DssRole.get(params.id)
        if (!dssRoleInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssRole.label', default: 'DssRole'), params.id])
            redirect action: 'list'
            return
        }

        [dssRoleInstance: dssRoleInstance]
    }

    def edit() {
		switch (request.method) {
		case 'GET':
	        def dssRoleInstance = DssRole.get(params.id)
	        if (!dssRoleInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssRole.label', default: 'DssRole'), params.id])
	            redirect action: 'list'
	            return
	        }

	        [dssRoleInstance: dssRoleInstance]
			break
		case 'POST':
	        def dssRoleInstance = DssRole.get(params.id)
	        if (!dssRoleInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssRole.label', default: 'DssRole'), params.id])
	            redirect action: 'list'
	            return
	        }

	        if (params.version) {
	            def version = params.version.toLong()
	            if (dssRoleInstance.version > version) {
	                dssRoleInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
	                          [message(code: 'dssRole.label', default: 'DssRole')] as Object[],
	                          "Another user has updated this DssRole while you were editing")
	                render view: 'edit', model: [dssRoleInstance: dssRoleInstance]
	                return
	            }
	        }

	        dssRoleInstance.properties = params

	        if (!dssRoleInstance.save(flush: true)) {
	            render view: 'edit', model: [dssRoleInstance: dssRoleInstance]
	            return
	        }

			flash.message = message(code: 'default.updated.message', args: [message(code: 'dssRole.label', default: 'DssRole'), dssRoleInstance.id])
	        redirect action: 'show', id: dssRoleInstance.id
			break
		}
    }

    def delete() {
        def dssRoleInstance = DssRole.get(params.id)
        if (!dssRoleInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'dssRole.label', default: 'DssRole'), params.id])
            redirect action: 'list'
            return
        }

        try {
            dssRoleInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'dssRole.label', default: 'DssRole'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dssRole.label', default: 'DssRole'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
