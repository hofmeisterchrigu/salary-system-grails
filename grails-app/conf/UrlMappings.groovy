class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
		"/"(controller:"DashBoard",action:"index")
//		"/"(view:"/index")
		"500"(view:'/errors/500')
		"404"(view:'/errors/404')
	}
}
