module kind_of_human

function Human = |firstName, lastName| {
	
	println("Constructor(%s, %s)":format(firstName, lastName))

	# Oh p... on dirait du javascript!
	
	return DynamicObject()
		:firstName(firstName)
		:lastName(lastName)
		:define("toString",|this| {
			return this:firstName()+" "+
			this:lastName()
		})
}

function main = |args| {
	let bob = Human("Bob", "Morane")
	let john = Human("John", "Doe")

	println(bob: toString() + " & " + john: toString())
}