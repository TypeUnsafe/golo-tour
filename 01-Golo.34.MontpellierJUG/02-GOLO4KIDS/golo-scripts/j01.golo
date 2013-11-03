module madagascar
#Golo4kids-01

function main = |args| {
	
	let marty = Zebre("Marty")
	let alex = Lion("Alex")

	alex:x(5):y(8):rugit()

	println(alex:x()+" "+alex:y())

	alex:bouge():droite(1):haut(5)

	alex:position():rugit()

	println(marty:nom())
	marty:nom("MARTY")

	marty:position()
}