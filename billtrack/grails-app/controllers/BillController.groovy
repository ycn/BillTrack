

class BillController extends BaseController {
	
	def beforeInterceptor = [action:this.&auth]
    
    def index = { redirect(action:list,params:params) }

    static allowedMethods = [delete:'POST', save:'POST', done:'POST', checkoutresult:'POST']

    def list = {
		params.max = Math.min( params.max ? params.max.toInteger() : 20,  100)
		params.offset = params.offset ? params.offset.toInteger() : 0
		params.sort = params.sort ? params.sort : "createdDate"
		params.order = params.order ? params.order : "desc"		
				
		def c = Bill.createCriteria()
		def results = c {
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
		def map = new HashMap()
		def sum = 0
		def num = 0
		results.each{
			sum = 0
			num = 0
			it.accounts.each{
				if (it.confirmed) num++
				sum += it.cost as BigDecimal
			}
			map[(it.id)] = ['confirmed_num':num,
			                'confirmed_cost':sum,
			                'eq_num':(num == it.accounts.size()),
			                'eq_cost':(sum == it.cost as BigDecimal)]
		}
		_base.putAll([ map:map,
		               billInstanceList: results,
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
	                session.load_ttl = 1
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
	                session.load_ttl = 1
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
            session.load_ttl = 1
            redirect(action:edit,id:billInstance.id)
        }
        else {
        	_base.putAll([billInstance:billInstance])
            render(view:'create',model:_base)
        }
    }
	
	def checkout = {
		def c = Bill.createCriteria()
		def results = c {
			eq('checkOut', false)
			order("createdDate", "desc")
		}
		def map = new HashMap()
		def sum = 0
		def num = 0
		results.each{
			sum = 0
			num = 0
			it.accounts.each{
				if (it.confirmed) num++
				sum += it.cost as BigDecimal
			}
			map[(it.id)] = ['confirmed_num':num,
			                'confirmed_cost':sum,
			                'eq_num':(num == it.accounts.size()),
			                'eq_cost':(sum == it.cost as BigDecimal)]
		}
		_base.putAll([ map:map,
		               billInstanceList: results,
					   billInstanceTotal: results.size() ])
		return _base
	}
	
	def checkoutresult = {
		def billID
		def billInstance
		def paidmap = new HashMap()
		def consumedmap = new HashMap()
		def sum = 0
		def num = 0
		def checkout_num = 0
		params.each{
			try {
				billID = it.key.toInteger()
				billInstance = Bill.get(billID)
				if (billInstance) {
					sum = 0
					num = 0
					billInstance.accounts.each{
						if (it.confirmed) num++
						sum += it.cost as BigDecimal
					}
					if ( (num == billInstance.accounts.size())
						 && (sum == billInstance.cost as BigDecimal) ) {
						billInstance.checkOut = true;
						billInstance.checkOutDate = new Date()
						if(!billInstance.hasErrors() && billInstance.save()) {
							checkout_num++
							if (!paidmap.get(billInstance.payer.name, false))
								paidmap[(billInstance.payer.name)] = 0g
							paidmap[(billInstance.payer.name)] += billInstance.cost as BigDecimal
							billInstance.accounts.each{
								if (!consumedmap.get(it.consumer.name, false))
									consumedmap[(it.consumer.name)] = 0g
								consumedmap[(it.consumer.name)] += it.cost as BigDecimal
							}
			            }
					}
				}
			} catch (Exception e) {}
		}
		session.load_ttl = 1
		_base.putAll([checkout_num:checkout_num,
		              users:consumedmap.keySet(),
		              paidmap:paidmap,
		              consumedmap:consumedmap])
		return _base
	}
}
