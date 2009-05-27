

class PersonController extends BaseController {
	
	def beforeInterceptor = [action:this.&auth, except:['login']]
    
    def index = { redirect(action:home, params:params) }
	
	// the delete, save and update actions only accept POST requests
    static allowedMethods = [update:'POST', create:'GET']
	
	def home = {
		def c = Account.createCriteria()
		def results = c {
			eq('consumer', _base.User)
			eq('confirmed', false)
			bill {
				order("createdDate", "desc")
			}
		}
		def c2 = Bill.createCriteria()
		def results2 = c2 {
			eq('checkOut', false)
			order("createdDate", "desc")
		}
		_base.putAll([ SimpleMode: true,
		               accountInstanceList: results,
					   accountInstanceTotal: results.size(),
					   billInstanceList: results2,
					   billInstanceTotal: results2.size() ])
		return _base
	}

    def edit = { return _base }

    def update = {
		if(params.version) {
            def version = params.version.toLong()
            if(_base.User.version > version) {
            	_base.User.errors.rejectValue("version", "person.optimistic.locking.failure", "Another user has updated this Person while you were editing.")
                render(view:'edit',model:_base)
                return
            }
        }
		params.password = params.password.encodeAsMD5()
    	_base.User.properties = params
        if(!_base.User.hasErrors() && _base.User.save()) {
            flash.message = "Settings ${_base.User.toString()} updated"
            redirect(controller:'person',action:'home')
        }
        else {
            render(view:'edit',model:_base)
        }
    }

    def login = {
    	if (request.method == "POST") {
    		params.password = params.password.encodeAsMD5()
    		def person = Person.findByNameAndPassword(params.name, params.password)
    		if (person) {
    			session.UserID = person.id
    			loadStatus()
    			def redirectParams =
    				   session.originalRequestParams ?
    				   session.originalRequestParams :
    				   [controller:'person',action:'home']
    			redirect(redirectParams)
    		}
    		else {
    			flash.message = "Please enter a valid User Name and Password"
    		}
    	}
    	else {
    		if (_base.Authed) {
    			flash.message = "Allready logged in"
    			redirect(controller:'person',action:'home')
    		}
    	}
    }
    
    def logout = {
		clearSession()
    	flash.message = "Successfully log out"
    	redirect(controller:'person',action:'home')
    }
}
