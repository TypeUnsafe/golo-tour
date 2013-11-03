module demo

#elvis ?

import java.util.LinkedList

function Person = -> DynamicObject():name("John Doe")

function main = |args| {

	let bob = Person():name("Bob Morane")
	let john = Person()
	let sam = null

	let humansList = LinkedList()
		:append(bob)
		:append(sam)
		:append(john)

	foreach(human in humansList) {

		#println(human:name()) -> Exception
		#println(human?:name())
		println(human?: name() orIfNull "--NULL--")
	}

}
