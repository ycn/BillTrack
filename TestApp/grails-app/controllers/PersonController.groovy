

class PersonController extends BaseController {
	
	def beforeInterceptor = [action:this.&auth, except:['login']]
    
    def index = { 
		redirect(action:home, params:params)
	}
	
	def home = {
		def user = Person.get( session.UserID )
		if (!user) {
			this.askAuth()
		}
		else {
			def criteria = Account.createCriteria()
			def results = criteria {
				and {
					eq('consumer', user)
					eq('confirmed', false)
				}
				bill {
					order("createdDate", "desc")
				}
			}
			def criteria2 = Bill.createCriteria()
			def results2 = criteria2 {
				eq('checkOut', false)
				maxResults(30)
				order("createdDate", "desc")
			}
			return [ accountInstanceList: results,
			         accountInstanceTotal: results.size(),
			         billInstanceList: results2,
			         billInstanceTotal: results2.size(),
			         user: user, now:new Date(), ifTrue:this.&ifTrue  ]
		}
	}

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [update:'POST']
	
    def edit = {
		def personInstance = Person.get( session.UserID )
        if(!personInstance) {
        	this.askAuth()
        }
        else {
            return [ personInstance : personInstance ]
        }
    }

    def update = {
        def personInstance = Person.get( session.UserID )
        if(personInstance) {
        	if(params.version) {
                def version = params.version.toLong()
                if(personInstance.version > version) {
                    
                    personInstance.errors.rejectValue("version", "person.optimistic.locking.failure", "Another user has updated this Person while you were editing.")
                    render(view:'edit',model:[personInstance:personInstance])
                    return
                }
            }
            personInstance.properties = params
            if(!personInstance.hasErrors() && personInstance.save()) {
                flash.message = "Person ${personInstance.toString()} updated"
                redirect(uri:'/')
            }
            else {
                render(view:'edit',model:[personInstance:personInstance])
            }
        }
        else {
        	this.askAuth()
        }
		
    }

    def login = {
    	if (request.method == "POST") {
    		def person = Person.findByNameAndPassword(params.name, params.password)
    		if (person) {
    			session.UserID = person.id
    			def redirectParams =
    				   session.originalRequestParams ?
    				   session.originalRequestParams :
    				   [uri:'/']
    			redirect(redirectParams)
    		}
    		else {
    			flash.message = "Please enter a valid User Name and Password"
    		}
    	}
    	else {
    		if (this.isAuth()) {
    			flash.message = "Allready logged in"
    			redirect(uri:'/')
    		}
    	}
    }
    
    def logout = {
		session.UserID = null
		session.originalRequestParams = null
    	flash.message = "Successfully log out"
    	redirect(uri:'/')
    }
}
