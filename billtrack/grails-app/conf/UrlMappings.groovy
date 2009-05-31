class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(view:"/index")
	  "500"(view:'/error')
	  "/home"{
    	  controller = "person"
    	  action = "home"
      }
      "/settings"{
    	  controller = "person"
    	  action = "edit"
      }
      "/login"{
    	  controller = "person"
    	  action = "login"
      }
      "/logout"{
    	  controller = "person"
    	  action = "logout"
      }
      "/checkout"{
    	  controller = "bill"
    	  action = "checkout"
      }
      "/checkout/result"{
    	  controller = "bill"
    	  action = "checkoutresult"
      }
      "/settings"{
    	  controller = "person"
    	  action = "edit"
      }
	}
}
