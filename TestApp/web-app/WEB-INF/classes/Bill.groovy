class Bill {
	// Fields
	String	address
	String	comment
	Person	payer
	Float	cost
	
	// default values
	Date	createdDate = new Date()
	Boolean	checkOut = false
	Date	checkOutDate = new Date()
	
	// Optional - Can be null
	def optionals = ["comment"]
	
	// One bill has many Accounts
	static hasMany = [accounts:Account]

    static constraints = {
		address(minLength:8, maxLength:200)
		cost(min:0.0f, max:999.99f, blank:false)
		payer(nullable:false)
		comment(maxLength:1000)
		createdDate(validator:{return (it > new Date())})
		checkOut(inList:[false, true], blank:false)
		checkOutDate(validator:{return (it > new Date())})
    }
	
	String toString() {"Bill:${this.address}/${this.payer}[${this.createdDate}]"}
}
