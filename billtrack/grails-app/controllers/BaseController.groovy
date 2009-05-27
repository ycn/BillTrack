
abstract class BaseController {
	def auth() {
		if(!this.isAuth()) {
			def originalRequestParams = [controller:controllerName, action:actionName]
			originalRequestParams.putAll(params)
			session.originalRequestParams = originalRequestParams
			redirect(controller:'person',action:'login')
			return false
		}
		else {
			session.originalRequestParams = null
			this.caculate()
		}
	}
	
	def caculate() {
		def user = Person.get( session.UserID )
		if (user) {
			def criteria = Bill.createCriteria()
			def toCheckOutDate = criteria.get {
				eq('checkOut', false)
				projections {
					min('createdDate')
				}
			}
			def criteria2 = Bill.createCriteria()
			def totalPaid = criteria2.get {
				eq('payer', user)
				eq('checkOut', false)
				projections {
					sum('cost')
				}
			}
			def criteria3 = Account.createCriteria()
			def totalConsumed = criteria3.get {
				eq('consumer', user)
				bill {
					eq('checkOut', false)
				}
				projections {
					sum('cost')
				}
			}
			if (toCheckOutDate) session.toCheckOutDate = toCheckOutDate
			if (totalPaid) session.totalPaid = totalPaid
			if (totalConsumed) session.totalConsumed = totalConsumed
		}
	}
	
	def isAuth() {
		if (!session.UserID) return false
		return true
	}

	def askAuth() {
		session.UserID = null
		session.originalRequestParams = null
		flash.message = "Please log in"
        redirect(controller:'person',action:'login')
	}
	
	def permissionDenied() {
		flash.message = "Permission Denied"
		redirect(uri:'/')
	}
	
	def ifTrue(cond, ret) {
		if (cond) {
			return ret
		}
	}
}