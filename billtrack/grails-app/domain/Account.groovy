class Account {
	Bill	bill
	Person	consumer
	Float	cost
	String	comment
	Boolean	confirmed = false
	Date	confirmedDate
	
	def belongsTo = Bill
	
    static constraints = {
		bill(nullable:false)
		consumer(nullable:false)
		cost(min:0.00f, max:999.99f, nullable:false, blank:false)
		comment(maxSize:1000, nullable:true)
		confirmed(inList:[false, true], nullable:false, blank:false)
		confirmedDate(nullable:true)
    }
	
	String toString() {
		"A#${this.consumer}/${this.cost}"
	}
}
