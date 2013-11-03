module demo

#DynamicObject ♥ ♥ ♥
#DynamicObject mixin 

function main = |args| {
	
	let bob = DynamicObject()
		:firstName("Bob")
		:lastName("Morane")
		:define("hello",|this|{
			println(this:firstName()+" "
				+this:lastName())
		})

	bob:hello()

	let bobby = DynamicObject()
		:mixin(bob)
		:lastName("Marley")

	bobby:hello()
	

}