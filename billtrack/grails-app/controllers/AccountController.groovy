

class AccountController extends BaseController {
    
	def beforeInterceptor = [action:this.&auth]
	
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', done:'POST']

    def list = {
		params.max = Math.min( params.max ? params.max.toInteger() : 20,  100)
		params.offset = params.offset ? params.offset.toInteger() : 0
		params.sort = params.sort ? params.sort : "createdDate"
		params.order = params.order ? params.order : "desc"
				
		def c = Account.createCriteria()
		def result = c {
			eq('consumer', _base.User)
			maxResults(params.max)
			firstResult(params.offset)
			if (params.sort == "createdDate") {
				bill {
					order(params.sort, params.order)
				}
			}
			else {
				order(params.sort, params.order)
			}
		}
		def c2 = Account.createCriteria()
		def total = c2.get {
			eq('consumer', _base.User)
			projections {
				rowCount()
			}
		}
		_base.putAll([ accountInstanceList: result,
		               accountInstanceTotal: total ])
		return _base
    }

    def show = {
        def accountInstance = Account.get( params.id )
        if(!accountInstance) {
            flash.message = "Account not found"
            redirect(action:list)
        }
        else {
        	_base.putAll([ accountInstance : accountInstance ])
        	return _base
        }
    }

    def delete = {
        def accountInstance = Account.get( params.id )
        if(accountInstance) {
        	if (_base.User == accountInstance.consumer) {
	            try {
	                accountInstance.delete()
	                flash.message = "Account ${accountInstance.toString()} deleted"
	                loadStatus()
	                redirect(action:list)
	            }
	            catch(org.springframework.dao.DataIntegrityViolationException e) {
	                flash.message = "Account ${accountInstance.toString()} could not be deleted"
	                redirect(action:show,id:params.id)
	            }
        	}
        	else {
        		permissionDenied()
        	}
        }
        else {
            flash.message = "Account not found"
            redirect(action:list)
        }
    }

    def edit = {
        def accountInstance = Account.get( params.id )
        if(!accountInstance) {
            flash.message = "Account not found"
            redirect(action:list)
        }
        else {
        	if (_base.User == accountInstance.consumer) {
        		_base.putAll([ accountInstance : accountInstance ])
        		return _base
        	}
        	else {
        		permissionDenied()
        	}
        }
    }

    def done = {
        def accountInstance = Account.get( params.id )
        if(accountInstance) {
        	if (_base.User == accountInstance.consumer) {
	            if(params.version) {
	                def version = params.version.toLong()
	                if(accountInstance.version > version) {
	                    accountInstance.errors.rejectValue("version", "account.optimistic.locking.failure", "Another user has updated this Account while you were editing.")
	                    _base.putAll([accountInstance:accountInstance])
	                    render(view:'edit',model:_base)
	                    return
	                }
	            }
	            accountInstance.properties = params
	            if (accountInstance.confirmed) {
	            	accountInstance.confirmedDate = new Date()
	            	loadStatus()
	            }
	            if(!accountInstance.hasErrors() && accountInstance.save()) {
	                flash.message = "Account ${accountInstance.toString()} updated"
	                redirect(action:show,id:accountInstance.id)
	            }
	            else {
	            	_base.putAll([accountInstance:accountInstance])
                    render(view:'edit',model:_base)
	            }
        	}
        	else {
        		permissionDenied()
        	}
        }
        else {
            flash.message = "Account not found"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
		if (params['bill.id']) {
	        def accountInstance = new Account()
	        accountInstance.properties = params
	        _base.putAll([accountInstance:accountInstance, PersonList:Person.list()])
	        return _base
		}
		else {
			permissionDenied()
		}
    }

    def save = {
        def accountInstance = new Account(params)
        if(!accountInstance.hasErrors() && accountInstance.save()) {
            flash.message = "Account ${accountInstance.toString()} created"
            loadStatus()
            if (_base.User == accountInstance.bill.payer) {
            	redirect(controller:'bill',action:'edit',id:accountInstance.bill.id)
            }
            else {
            	redirect(controller:'bill',action:'show',id:accountInstance.bill.id)
            }
        }
        else {
        	_base.putAll([accountInstance:accountInstance, PersonList:Person.list()])
        	render(view:'create',model:_base)
        }
    }
}
