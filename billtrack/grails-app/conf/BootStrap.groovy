class BootStrap {

     def init = { servletContext ->
		if (!Person.findByName('admin')) {
			def admin = new Person([name:'admin',password:'admin'.encodeAsMD5()])
			admin.save()
		}
     }
     def destroy = {
     }
} 
