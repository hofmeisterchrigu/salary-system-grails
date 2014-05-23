package com.deerwalk.dss

import grails.test.mixin.*

@TestFor(SettingController)
@Mock(SalaryConfiguration)
class SettingControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/setting/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.settingInstanceList.size() == 0
        assert model.settingInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.settingInstance != null
    }

    void testSave() {
        controller.save()

        assert model.settingInstance != null
        assert view == '/setting/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/setting/show/1'
        assert controller.flash.message != null
        assert SalaryConfiguration.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/setting/list'

        populateValidParams(params)
        def setting = new SalaryConfiguration(params)

        assert setting.save() != null

        params.id = setting.id

        def model = controller.show()

        assert model.settingInstance == setting
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/setting/list'

        populateValidParams(params)
        def setting = new SalaryConfiguration(params)

        assert setting.save() != null

        params.id = setting.id

        def model = controller.edit()

        assert model.settingInstance == setting
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/setting/list'

        response.reset()

        populateValidParams(params)
        def setting = new SalaryConfiguration(params)

        assert setting.save() != null

        // test invalid parameters in update
        params.id = setting.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/setting/edit"
        assert model.settingInstance != null

        setting.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/setting/show/$setting.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        setting.clearErrors()

        populateValidParams(params)
        params.id = setting.id
        params.version = -1
        controller.update()

        assert view == "/setting/edit"
        assert model.settingInstance != null
        assert model.settingInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/setting/list'

        response.reset()

        populateValidParams(params)
        def setting = new SalaryConfiguration(params)

        assert setting.save() != null
        assert SalaryConfiguration.count() == 1

        params.id = setting.id

        controller.delete()

        assert SalaryConfiguration.count() == 0
        assert SalaryConfiguration.get(setting.id) == null
        assert response.redirectedUrl == '/setting/list'
    }
}
