

class BillController extends BaseController {
	
	def beforeInterceptor = [action:this.&auth]
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        def user = Person.get( session.UserID )
        if (user) {
        	[ billInstanceList: user.paidBills , billInstanceTotal: user.paidBills.size() ]
        }
        else {
        	this.askAuth()
        }
    }

    def show = {
        def billInstance = Bill.get( params.id )

        if(!billInstance) {
            flash.message = "Bill not found"
            redirect(action:list)
        }
        else { return [ billInstance : billInstance ] }
    }

    def delete = {
        def billInstance = Bill.get( params.id )
        if(billInstance) {
        	if (session.UserID == billInstance.payer.id) {
	            try {
	                billInstance.delete()
	                flash.message = "Bill ${billInstance.toString()} deleted"
	                redirect(action:list)
	            }
	            catch(org.springframework.dao.DataIntegrityViolationException e) {
	                flash.message = "Bill ${billInstance.toString()} could not be deleted"
	                redirect(action:show,id:params.id)
	            }
        	}
        	else {
        		this.permissionDenied()
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
        	if (session.UserID == billInstance.payer.id) {
        		return [ billInstance : billInstance ]
        	}
        	else {
        		this.permissionDenied()
        	}
        }
    }

    def update = {
        def billInstance = Bill.get( params.id )
        if(billInstance) {
        	if (session.UserID == billInstance.payer.id) {
	            if(params.version) {
	                def version = params.version.toLong()
	                if(billInstance.version > version) {
	                    
	                    billInstance.errors.rejectValue("version", "bill.optimistic.locking.failure", "Another user has updated this Bill while you were editing.")
	                    render(view:'edit',model:[billInstance:billInstance])
	                    return
	                }
	            }
	            billInstance.properties = params
	            if(!billInstance.hasErrors() && billInstance.save()) {
	                flash.message = "Bill ${billInstance.toString()} updated"
	                redirect(action:show,id:billInstance.id)
	            }
	            else {
	                render(view:'edit',model:[billInstance:billInstance])
	            }
        	}
        	else {
        		this.permissionDenied()
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
        return ['billInstance':billInstance]
    }

    def save = {
        def billInstance = new Bill(params)
        if(!billInstance.hasErrors() && billInstance.save()) {
        	session.billID = billInstance.id
            flash.message = "Bill ${billInstance.toString()} created"
            redirect(action:edit,id:billInstance.id)
        }
        else {
        	session.billID = null
            render(view:'create',model:[billInstance:billInstance])
        }
    }
}
