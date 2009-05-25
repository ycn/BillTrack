

class AccountController extends BaseController {
    
	def beforeInterceptor = [action:this.&auth]
	
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
		def user = Person.get( session.UserID )
		if (user) {
			[ accountInstanceList: user.accounts, accountInstanceTotal: user.accounts.size() ]
		}
		else {
			this.askAuth()
		}
    }

    def show = {
        def accountInstance = Account.get( params.id )

        if(!accountInstance) {
            flash.message = "Account not found"
            redirect(action:list)
        }
        else {
        	return [ accountInstance : accountInstance ]
        }
    }

    def delete = {
        def accountInstance = Account.get( params.id )
        if(accountInstance) {
        	if (session.UserID == accountInstance.consumer.id) {
	            try {
	                accountInstance.delete()
	                flash.message = "Account ${accountInstance.toString()} deleted"
	                redirect(action:list)
	            }
	            catch(org.springframework.dao.DataIntegrityViolationException e) {
	                flash.message = "Account ${accountInstance.toString()} could not be deleted"
	                redirect(action:show,id:params.id)
	            }
        	}
        	else {
        		this.permissionDenied()
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
        	if (session.UserID == accountInstance.consumer.id) {
        		return [ accountInstance : accountInstance ]
        	}
        	else {
        		this.permissionDenied()
        	}
        }
    }

    def update = {
        def accountInstance = Account.get( params.id )
        if(accountInstance) {
        	if (session.UserID == accountInstance.consumer.id) {
	            if(params.version) {
	                def version = params.version.toLong()
	                if(accountInstance.version > version) {
	                    
	                    accountInstance.errors.rejectValue("version", "account.optimistic.locking.failure", "Another user has updated this Account while you were editing.")
	                    render(view:'edit',model:[accountInstance:accountInstance])
	                    return
	                }
	            }
	            accountInstance.properties = params
	            if(!accountInstance.hasErrors() && accountInstance.save()) {
	                flash.message = "Account ${accountInstance.toString()} updated"
	                redirect(action:show,id:accountInstance.id)
	            }
	            else {
	                render(view:'edit',model:[accountInstance:accountInstance])
	            }
        	}
        	else {
        		this.permissionDenied()
        	}
        }
        else {
            flash.message = "Account not found"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def accountInstance = new Account()
        accountInstance.properties = params
        return ['accountInstance':accountInstance]
    }

    def save = {
        def accountInstance = new Account(params)
        if(!accountInstance.hasErrors() && accountInstance.save()) {
            flash.message = "Account ${accountInstance.toString()} created"
            if (session.billID) {
            	redirect(controller:'bill',action:'edit',id:session.billID)
            }
            else {
            	redirect(uri:'/')
            }
        }
        else {
        	render(view:'create',model:[accountInstance:accountInstance])
        }
    }
}
