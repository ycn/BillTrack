

class BillController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ billInstanceList: Bill.list( params ), billInstanceTotal: Bill.count() ]
    }

    def show = {
        def billInstance = Bill.get( params.id )

        if(!billInstance) {
            flash.message = "Bill not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ billInstance : billInstance ] }
    }

    def delete = {
        def billInstance = Bill.get( params.id )
        if(billInstance) {
            try {
                billInstance.delete()
                flash.message = "Bill ${params.toString()} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Bill ${params.toString()} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Bill not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def billInstance = Bill.get( params.id )

        if(!billInstance) {
            flash.message = "Bill not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ billInstance : billInstance ]
        }
    }

    def update = {
        def billInstance = Bill.get( params.id )
        if(billInstance) {
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
                flash.message = "Bill ${params.toString()} updated"
                redirect(action:show,id:billInstance.id)
            }
            else {
                render(view:'edit',model:[billInstance:billInstance])
            }
        }
        else {
            flash.message = "Bill not found with id ${params.id}"
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
            flash.message = "Bill ${billInstance.toString()} created"
            redirect(action:show,id:billInstance.id)
        }
        else {
            render(view:'create',model:[billInstance:billInstance])
        }
    }
}
