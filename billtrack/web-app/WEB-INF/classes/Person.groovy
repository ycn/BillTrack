class Person {
	String name
	String password
	
	static hasMany = [paidBills:Bill, accounts:Account]
	
    static constraints = {
		name(size:2..20, unique:true, nullable:false, blank:false)
		password(size:6..128, nullable:false, blank:false)
    }
	
	String toString() {"${this.name}"}
}
