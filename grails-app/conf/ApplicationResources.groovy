modules = {
    application {
        resource url:'js/application.js'
    }
	mainLayout {
        dependsOn "highcharts"
		resource url:"/css/style.css"


	}
    typehead{
        resource url:"/js/bootstrap-typeahead.min.js"
    }
	jquery{
		resource url:"/js/jquery/jquery-1.7.2.min.js"

	}

    highcharts{
        dependsOn "jquery"
//        resource url:"/js/highcharts.js"
        resource url:"/js/highcharts.src.js"
    }

}