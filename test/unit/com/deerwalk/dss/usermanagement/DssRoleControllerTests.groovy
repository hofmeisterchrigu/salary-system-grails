package com.deerwalk.dss.usermanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(DssRoleController)
@Mock(DssRole)
class DssRoleControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/dssRole/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.dssRoleInstanceList.size() == 0
        assert model.dssRoleInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.dssRoleInstance != null
    }

    void testSave() {
        controller.save()

        assert model.dssRoleInstance != null
        assert view == '/dssRole/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/dssRole/show/1'
        assert controller.flash.message != null
        assert DssRole.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/dssRole/list'

        populateValidParams(params)
        def dssRole = new DssRole(params)

        assert dssRole.save() != null

        params.id = dssRole.id

        def model = controller.show()

        assert model.dssRoleInstance == dssRole
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/dssRole/list'

        populateValidParams(params)
        def dssRole = new DssRole(params)

        assert dssRole.save() != null

        params.id = dssRole.id

        def model = controller.edit()

        assert model.dssRoleInstance == dssRole
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/dssRole/list'

        response.reset()

        populateValidParams(params)
        def dssRole = new DssRole(params)

        assert dssRole.save() != null

        // test invalid parameters in update
        params.id = dssRole.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/dssRole/edit"
        assert model.dssRoleInstance != null

        dssRole.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/dssRole/show/$dssRole.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        dssRole.clearErrors()

        populateValidParams(params)
        params.id = dssRole.id
        params.version = -1
        controller.update()

        assert view == "/dssRole/edit"
        assert model.dssRoleInstance != null
        assert model.dssRoleInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/dssRole/list'

        response.reset()

        populateValidParams(params)
        def dssRole = new DssRole(params)

        assert dssRole.save() != null
        assert DssRole.count() == 1

        params.id = dssRole.id

        controller.delete()

        assert DssRole.count() == 0
        assert DssRole.get(dssRole.id) == null
        assert response.redirectedUrl == '/dssRole/list'
    }
}
