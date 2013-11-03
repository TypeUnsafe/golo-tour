module madagascar
#Golo4kids-04
function main = |args| {
	
	dire que alex = Lion("Alex")

	alex
		:x(5):y(8)
		:rugit():mange("steak")
		:bouge()
			:droite(1):haut(5)

	alex:position()

	si alex:x() > 3 {
		message("x est plus grand que 3")
	} sinon {
		message("x est moins grand que 3")
	}

}