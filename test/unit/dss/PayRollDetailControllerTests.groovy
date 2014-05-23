package dss



import org.junit.*
import grails.test.mixin.*

@TestFor(PayRollDetailController)
@Mock(PayRollDetail)
class PayRollDetailControllerTests {

	def populateValidParams(params) {
		assert params != null
		// TODO: Populate valid properties like...
		//params["name"] = 'someValidName'
	}

	void testIndex() {
		controller.index()
		assert "/payRollDetail/list" == response.redirectedUrl
	}

	void testList() {

		def model = controller.list()

		assert model.payRollDetailInstanceList.size() == 0
		assert model.payRollDetailInstanceTotal == 0
	}

	void testCreate() {
		def model = controller.create()

		assert model.payRollDetailInstance != null
	}

	void testSave() {
		controller.save()

		assert model.payRollDetailInstance != null
		assert view == '/payRollDetail/create'

		response.reset()

		populateValidParams(params)
		controller.save()

		assert response.redirectedUrl == '/payRollDetail/show/1'
		assert controller.flash.message != null
		assert PayRollDetail.count() == 1
	}

	void testShow() {
		controller.show()

		assert flash.message != null
		assert response.redirectedUrl == '/payRollDetail/list'

		populateValidParams(params)
		def payRollDetail = new PayRollDetail(params)

		assert payRollDetail.save() != null

		params.id = payRollDetail.id

		def model = controller.show()

		assert model.payRollDetailInstance == payRollDetail
	}

	void testEdit() {
		controller.edit()

		assert flash.message != null
		assert response.redirectedUrl == '/payRollDetail/list'

		populateValidParams(params)
		def payRollDetail = new PayRollDetail(params)

		assert payRollDetail.save() != null

		params.id = payRollDetail.id

		def model = controller.edit()

		assert model.payRollDetailInstance == payRollDetail
	}

	void testUpdate() {
		controller.update()

		assert flash.message != null
		assert response.redirectedUrl == '/payRollDetail/list'

		response.reset()

		populateValidParams(params)
		def payRollDetail = new PayRollDetail(params)

		assert payRollDetail.save() != null

		// test invalid parameters in update
		params.id = payRollDetail.id
		//TODO: add invalid values to params object

		controller.update()

		assert view == "/payRollDetail/edit"
		assert model.payRollDetailInstance != null

		payRollDetail.clearErrors()

		populateValidParams(params)
		controller.update()

		assert response.redirectedUrl == "/payRollDetail/show/$payRollDetail.id"
		assert flash.message != null

		//test outdated version number
		response.reset()
		payRollDetail.clearErrors()

		populateValidParams(params)
		params.id = payRollDetail.id
		params.version = -1
		controller.update()

		assert view == "/payRollDetail/edit"
		assert model.payRollDetailInstance != null
		assert model.payRollDetailInstance.errors.getFieldError('version')
		assert flash.message != null
	}

	void testDelete() {
		controller.delete()
		assert flash.message != null
		assert response.redirectedUrl == '/payRollDetail/list'

		response.reset()

		populateValidParams(params)
		def payRollDetail = new PayRollDetail(params)

		assert payRollDetail.save() != null
		assert PayRollDetail.count() == 1

		params.id = payRollDetail.id

		controller.delete()

		assert PayRollDetail.count() == 0
		assert PayRollDetail.get(payRollDetail.id) == null
		assert response.redirectedUrl == '/payRollDetail/list'
	}
}
