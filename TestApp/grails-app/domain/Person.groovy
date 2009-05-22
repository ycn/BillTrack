class Person {
	String name
	
	static hasMany = [paidBills:Bill, accounts:Account]
	
    static constraints = {
		name(size:3..30, unique:true, nullable:false, blank:false)
    }
	
	String toString() {"${this.name}"}
}
