module dynamicobjects

function main = |args| {
	
	let bob = DynamicObject()
		:firstName("BOB")
		:lastName("MORANE")

	println(bob:firstName() + " " + bob:lastName())

	bob:define("display", |this| ->
		println(this:firstName() + " " + this:lastName())
	)

	bob:display()

	let john = DynamicObject():mixin(bob) #kind of inheritance
							:nickName("Johnny")
							:firstName("John")
							:lastName("Doe")
	
	john:display()

}



