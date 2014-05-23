package com.deerwalk.dss



import org.junit.*
import grails.test.mixin.*

@TestFor(PayRollController)
@Mock(PayRoll)
class PayRollControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/payRoll/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.payRollInstanceList.size() == 0
        assert model.payRollInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.payRollInstance != null
    }

    void testSave() {
        controller.save()

        assert model.payRollInstance != null
        assert view == '/payRoll/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/payRoll/show/1'
        assert controller.flash.message != null
        assert PayRoll.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/payRoll/list'

        populateValidParams(params)
        def payRoll = new PayRoll(params)

        assert payRoll.save() != null

        params.id = payRoll.id

        def model = controller.show()

        assert model.payRollInstance == payRoll
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/payRoll/list'

        populateValidParams(params)
        def payRoll = new PayRoll(params)

        assert payRoll.save() != null

        params.id = payRoll.id

        def model = controller.edit()

        assert model.payRollInstance == payRoll
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/payRoll/list'

        response.reset()

        populateValidParams(params)
        def payRoll = new PayRoll(params)

        assert payRoll.save() != null

        // test invalid parameters in update
        params.id = payRoll.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/payRoll/edit"
        assert model.payRollInstance != null

        payRoll.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/payRoll/show/$payRoll.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        payRoll.clearErrors()

        populateValidParams(params)
        params.id = payRoll.id
        params.version = -1
        controller.update()

        assert view == "/payRoll/edit"
        assert model.payRollInstance != null
        assert model.payRollInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/payRoll/list'

        response.reset()

        populateValidParams(params)
        def payRoll = new PayRoll(params)

        assert payRoll.save() != null
        assert PayRoll.count() == 1

        params.id = payRoll.id

        controller.delete()

        assert PayRoll.count() == 0
        assert PayRoll.get(payRoll.id) == null
        assert response.redirectedUrl == '/payRoll/list'
    }
}
