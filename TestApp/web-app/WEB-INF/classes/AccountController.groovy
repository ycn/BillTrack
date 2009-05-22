

class AccountController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ accountInstanceList: Account.list( params ), accountInstanceTotal: Account.count() ]
    }

    def show = {
        def accountInstance = Account.get( params.id )

        if(!accountInstance) {
            flash.message = "Account not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ accountInstance : accountInstance ] }
    }

    def delete = {
        def accountInstance = Account.get( params.id )
        if(accountInstance) {
            try {
                accountInstance.delete()
                flash.message = "Account ${params.toString()} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Account ${params.toString()} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Account not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def accountInstance = Account.get( params.id )

        if(!accountInstance) {
            flash.message = "Account not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ accountInstance : accountInstance ]
        }
    }

    def update = {
        def accountInstance = Account.get( params.id )
        if(accountInstance) {
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
                flash.message = "Account ${params.toString()} updated"
                redirect(action:show,id:accountInstance.id)
            }
            else {
                render(view:'edit',model:[accountInstance:accountInstance])
            }
        }
        else {
            flash.message = "Account not found with id ${params.id}"
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
            redirect(action:show,id:accountInstance.id)
        }
        else {
            render(view:'create',model:[accountInstance:accountInstance])
        }
    }
}
