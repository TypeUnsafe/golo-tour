module golo4kids

function main = |args| {
	let winnie = Animal("Winnie")

	winnie: x(5): y(10)

	winnie: afficherPosition()

	winnie: nom(winnie: nom()+" the pooh")
	
	println(winnie: nom())

}