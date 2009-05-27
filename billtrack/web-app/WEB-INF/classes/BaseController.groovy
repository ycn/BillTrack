
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
			_base.putAll([ Authed: true,
			               User: Person.get(session.UserID) ])
		}
	}
	
	def loadStatus() {
		if (session.UserID) {
			def user = Person.get(session.UserID)
			def c = Bill.createCriteria()
			def toCheckOutDate = c.get {
				eq('checkOut', false)
				projections {
					min('createdDate')
				}
			}
			def c2 = Bill.createCriteria()
			def totalPaid = c2.get {
				eq('payer', user)
				eq('checkOut', false)
				projections {
					sum('cost')
				}
			}
			def c3 = Account.createCriteria()
			def totalConsumed = c3.get {
				eq('consumer', user)
				bill {
					eq('checkOut', false)
				}
				projections {
					sum('cost')
				}
			}
			session.toCheckOutDate = toCheckOutDate ? toCheckOutDate : 'long long ago'
			session.totalPaid = totalPaid ? totalPaid : 0.0
			session.totalConsumed = totalConsumed ? totalConsumed : 0.0
		}
	}
	
	def clearSession() {
		session.UserID = null
		session.originalRequestParams = null
		session.toCheckOutDate = 'long long ago'
		session.totalPaid = 0.0
		session.totalConsumed = 0.0
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