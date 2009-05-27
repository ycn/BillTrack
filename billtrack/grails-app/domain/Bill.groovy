class Bill {
	// Fields
	String	address
	Person	payer
	Float	cost
	String	comment
	Date	createdDate = new Date()
	Boolean	checkOut = false
	Date	checkOutDate
	
	// One bill has many Accounts
	static hasMany = [accounts:Account]

    static constraints = {
		address(size:2..20, nullable:false, blank:false)
		payer(nullable:false)
		cost(min:0.00f, max:999.99f, nullable:false, blank:false)
		comment(maxSize:1000, nullable:true)
		createdDate(nullable:false)
		checkOut(inList:[false, true], nullable:false, blank:false)
		checkOutDate(nullable:true)
    }
	
	String toString() {"B#${this.address}/${this.cost}"}
}
