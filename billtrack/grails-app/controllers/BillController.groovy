

class BillController extends BaseController {
	
	def beforeInterceptor = [action:this.&auth]
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', done:'POST']

    def list = {
		params.max = Math.min( params.max ? params.max.toInteger() : 20,  100)
		params.offset = params.offset ? params.offset.toInteger() : 0
		params.sort = params.sort ? params.sort : "createdDate"
		params.order = params.order ? params.order : "desc"		
				
		def c = Bill.createCriteria()
		def result = c {
			eq('payer', _base.User)
			maxResults(params.max)
			firstResult(params.offset)
			order(params.sort, params.order)
		}
		def c2 = Bill.createCriteria()
		def total = c2.get {
			eq('payer', _base.User)
			projections {
				rowCount()
			}
		}
		_base.putAll([ billInstanceList: result,
		               billInstanceTotal: total ])
		return _base
    }

    def show = {
        def billInstance = Bill.get( params.id )
        if(!billInstance) {
            flash.message = "Bill not found"
            redirect(action:list)
        }
        else {
        	_base.putAll([ billInstance : billInstance ])
        	return _base
        }
    }

    def delete = {
        def billInstance = Bill.get( params.id )
        if(billInstance) {
        	if (_base.User == billInstance.payer) {
	            try {
	                billInstance.delete()
	                flash.message = "Bill ${billInstance.toString()} deleted"
	                loadStatus()
	                redirect(action:list)
	            }
	            catch(org.springframework.dao.DataIntegrityViolationException e) {
	                flash.message = "Bill ${billInstance.toString()} could not be deleted"
	                redirect(action:show,id:params.id)
	            }
        	}
        	else {
        		permissionDenied()
        	}
        }
        else {
            flash.message = "Bill not found"
            redirect(action:list)
        }
    }

    def edit = {
        def billInstance = Bill.get( params.id )
        if(!billInstance) {
            flash.message = "Bill not found"
            redirect(action:list)
        }
        else {
        	if (_base.User == billInstance.payer) {
        		_base.putAll([ billInstance : billInstance ])
        		return _base
        	}
        	else {
        		permissionDenied()
        	}
        }
    }

    def done = {
        def billInstance = Bill.get( params.id )
        if(billInstance) {
        	if (_base.User == billInstance.payer) {
	            if(params.version) {
	                def version = params.version.toLong()
	                if(billInstance.version > version) {
	                    billInstance.errors.rejectValue("version", "bill.optimistic.locking.failure", "Another user has updated this Bill while you were editing.")
	                    _base.putAll([billInstance:billInstance])
	                    render(view:'edit',model:_base)
	                    return
	                }
	            }
	            billInstance.properties = params
	            if(!billInstance.hasErrors() && billInstance.save()) {
	                flash.message = "Bill ${billInstance.toString()} updated"
	                loadStatus()
	                redirect(action:show,id:billInstance.id)
	            }
	            else {
	            	_base.putAll([billInstance:billInstance])
                    render(view:'edit',model:_base)
	            }
        	}
        	else {
        		permissionDenied()
        	}
        }
        else {
            flash.message = "Bill not found"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def billInstance = new Bill()
        billInstance.properties = params
        _base.putAll([billInstance:billInstance])
        return _base
    }

    def save = {
        def billInstance = new Bill(params)
        if(!billInstance.hasErrors() && billInstance.save()) {
            flash.message = "Bill ${billInstance.toString()} created"
            loadStatus()
            redirect(action:edit,id:billInstance.id)
        }
        else {
        	_base.putAll([billInstance:billInstance])
            return _base
        }
    }
	
	def checkout = {
		
	}
	
	def checkoutresult = {
		
	}
}
