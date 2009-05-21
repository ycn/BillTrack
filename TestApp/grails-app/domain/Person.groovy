class Person {
	String name
	
	static hasMany = [bills:Bill, accounts:Account]
	
    static constraints = {
		name(minLength:3, maxLength:30, unique:true, blank:false)
    }
	
	String toString() {"${this.name}"}
}
