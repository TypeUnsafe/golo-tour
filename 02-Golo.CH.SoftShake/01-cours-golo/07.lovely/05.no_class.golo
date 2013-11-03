module return_of_kind_of_human

# properties
struct human = { firstName,	lastName}
# methods
augment return_of_kind_of_human.types.human {
	function display = |this| {
		println(this:firstName() + " # " + this:lastName())
	}
}
# constructor
function Human = |first, last| ->
	human(first, last)

function main = |args| {
	let bob = Human("Bob", "Morane")
	let john = Human("John", "Doe")

	bob: display()
	john: display()
}