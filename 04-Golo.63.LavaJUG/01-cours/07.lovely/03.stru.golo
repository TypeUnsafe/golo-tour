module les_structures

struct human = {
		firstName
	,	lastName
}

function main = |args| {
	
	let bob = human("Bob", "Morane")
	let john = human()
							:firstName("John")
							:lastName("Doe")

	println(bob:firstName())
	println(john:lastName())
}
