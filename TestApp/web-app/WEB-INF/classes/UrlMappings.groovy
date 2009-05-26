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
      "/checkoutresult"{
    	  controller = "bill"
    	  action = "checkoutresult"
      }
      "/settings"{
    	  controller = "person"
    	  action = "edit"
      }
      "/bill"{
    	  controller = "bill"
    	  action = "create"
      }
      "/bill/$id"{
    	  controller = "bill"
    	  action = "show"
      }
      "/account"{
    	  controller = "account"
    	  action = "create"
      }
      "/account/$id"{
    	  controller = "account"
    	  action = "show"
      }
	}
}
