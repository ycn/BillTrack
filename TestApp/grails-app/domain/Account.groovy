class Account {
	Bill	bill
	Person	consumer
	Float	cost
	
	def belongsTo = Bill

    static constraints = {
		bill(nullable:false)
		consumer(nullable:false)
		cost(min:0.0f, max:999.99f, blank:false)
    }
	
	String toString() {"Account:${this.bill.address}/${this.consumer}[${this.bill.createdDate}]"}
}
