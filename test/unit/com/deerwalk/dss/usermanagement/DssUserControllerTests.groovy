package com.deerwalk.dss.usermanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(DssUserController)
@Mock(DssUser)
class DssUserControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/dssUser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.dssUserInstanceList.size() == 0
        assert model.dssUserInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.dssUserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.dssUserInstance != null
        assert view == '/dssUser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/dssUser/show/1'
        assert controller.flash.message != null
        assert DssUser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/dssUser/list'

        populateValidParams(params)
        def dssUser = new DssUser(params)

        assert dssUser.save() != null

        params.id = dssUser.id

        def model = controller.show()

        assert model.dssUserInstance == dssUser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/dssUser/list'

        populateValidParams(params)
        def dssUser = new DssUser(params)

        assert dssUser.save() != null

        params.id = dssUser.id

        def model = controller.edit()

        assert model.dssUserInstance == dssUser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/dssUser/list'

        response.reset()

        populateValidParams(params)
        def dssUser = new DssUser(params)

        assert dssUser.save() != null

        // test invalid parameters in update
        params.id = dssUser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/dssUser/edit"
        assert model.dssUserInstance != null

        dssUser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/dssUser/show/$dssUser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        dssUser.clearErrors()

        populateValidParams(params)
        params.id = dssUser.id
        params.version = -1
        controller.update()

        assert view == "/dssUser/edit"
        assert model.dssUserInstance != null
        assert model.dssUserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/dssUser/list'

        response.reset()

        populateValidParams(params)
        def dssUser = new DssUser(params)

        assert dssUser.save() != null
        assert DssUser.count() == 1

        params.id = dssUser.id

        controller.delete()

        assert DssUser.count() == 0
        assert DssUser.get(dssUser.id) == null
        assert response.redirectedUrl == '/dssUser/list'
    }
}
