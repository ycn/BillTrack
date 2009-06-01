
abstract class BaseController {
	def _base = [ Now: new Date(),
	              ifTrue: this.&ifTrue ]
	
	def auth() {
		if(!session.UserID) {
			def originalRequestParams = [controller:controllerName, action:actionName]
			originalRequestParams.putAll(params)
			session.originalRequestParams = originalRequestParams
			redirect(controller:'person',action:'login')
			return false
		}
		else {
			session.originalRequestParams = null
			loadStatus()
			_base.putAll([ Authed: true,
			               User: Person.get(session.UserID) ])
		}
	}
	
	def loadStatus() {
		if (!session.UserID) return
		if (!session.load_ttl) return
		if (session.load_ttl <= 0) return
		session.load_ttl--
		
		if (session.load_ttl == 0) {
			
			def user = Person.get(session.UserID)
			def c = Bill.createCriteria()
			def toCheckOutDate = c.get {
				eq('checkOut', false)
				projections {
					min('createdDate')
				}
			}
			def c2 = Bill.createCriteria()
			def results = c2 {
				eq('payer', user)
				eq('checkOut', false)
			}
			def totalPaid = 0
			results.each{
				totalPaid += it.cost as BigDecimal
			}
			
			def c3 = Account.createCriteria()
			def results2 = c3 {
				eq('consumer', user)
				bill {
					eq('checkOut', false)
				}
			}
			def totalConsumed = 0
			results2.each{
				totalConsumed += it.cost as BigDecimal
			}
			session.toCheckOutDate = toCheckOutDate ? toCheckOutDate : null
			session.totalPaid = totalPaid ? totalPaid : 0g
			session.totalConsumed = totalConsumed ? totalConsumed : 0g
		}
	}
	
	def clearSession() {
		session.UserID = null
		session.originalRequestParams = null
		session.toCheckOutDate = 'long long ago'
		session.totalPaid = 0g
		session.totalConsumed = 0g
	}

	def askAuth() {
		clearSession()
		flash.message = "Please log in"
        redirect(controller:'person',action:'login')
	}
	
	def permissionDenied() {
		flash.message = "Permission Denied"
		redirect(controller:'person',action:'home')
	}
	
	def ifTrue(cond, ret, eret) {
		return cond ? ret : eret;
	}
}