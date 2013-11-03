module demo

#DynamicObject : Like class [human]

function Human = |firstName, lastName| {

	println("Je suis un constructeur")

	return DynamicObject()
		:firstName(firstName)
		:lastName(lastName)
		:define("toString",|this| {
			return this:firstName()+" "+
			this:lastName()
		})

}

function main = |args| {

	let bob = Human("Bob","Marley")

	println(
		bob:toString()
	)

	bob:properties():each(|prop|->println(
		prop:getKey() + " -> " + prop:getValue()
	))

}
