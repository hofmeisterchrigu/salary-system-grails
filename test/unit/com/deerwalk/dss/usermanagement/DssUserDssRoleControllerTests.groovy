package com.deerwalk.dss.usermanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(DssUserDssRoleController)
@Mock(DssUserDssRole)
class DssUserDssRoleControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/dssUserDssRole/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.dssUserDssRoleInstanceList.size() == 0
        assert model.dssUserDssRoleInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.dssUserDssRoleInstance != null
    }

    void testSave() {
        controller.save()

        assert model.dssUserDssRoleInstance != null
        assert view == '/dssUserDssRole/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/dssUserDssRole/show/1'
        assert controller.flash.message != null
        assert DssUserDssRole.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/dssUserDssRole/list'

        populateValidParams(params)
        def dssUserDssRole = new DssUserDssRole(params)

        assert dssUserDssRole.save() != null

        params.id = dssUserDssRole.id

        def model = controller.show()

        assert model.dssUserDssRoleInstance == dssUserDssRole
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/dssUserDssRole/list'

        populateValidParams(params)
        def dssUserDssRole = new DssUserDssRole(params)

        assert dssUserDssRole.save() != null

        params.id = dssUserDssRole.id

        def model = controller.edit()

        assert model.dssUserDssRoleInstance == dssUserDssRole
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/dssUserDssRole/list'

        response.reset()

        populateValidParams(params)
        def dssUserDssRole = new DssUserDssRole(params)

        assert dssUserDssRole.save() != null

        // test invalid parameters in update
        params.id = dssUserDssRole.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/dssUserDssRole/edit"
        assert model.dssUserDssRoleInstance != null

        dssUserDssRole.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/dssUserDssRole/show/$dssUserDssRole.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        dssUserDssRole.clearErrors()

        populateValidParams(params)
        params.id = dssUserDssRole.id
        params.version = -1
        controller.update()

        assert view == "/dssUserDssRole/edit"
        assert model.dssUserDssRoleInstance != null
        assert model.dssUserDssRoleInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/dssUserDssRole/list'

        response.reset()

        populateValidParams(params)
        def dssUserDssRole = new DssUserDssRole(params)

        assert dssUserDssRole.save() != null
        assert DssUserDssRole.count() == 1

        params.id = dssUserDssRole.id

        controller.delete()

        assert DssUserDssRole.count() == 0
        assert DssUserDssRole.get(dssUserDssRole.id) == null
        assert response.redirectedUrl == '/dssUserDssRole/list'
    }
}
