
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
		}
	}
	
	def isAuth() {
		if (!session.UserID) return false
		if (!session.UserName) return false
		return true
	}

	def askAuth() {
		session.UserID = null
		session.UserName = null
		session.originalRequestParams = null
		flash.message = "Please log in"
        redirect(controller:'person',action:'login')
	}
	
	def permissionDenied() {
		flash.message = "Permission Denied"
		redirect(uri:'/')
	}
}