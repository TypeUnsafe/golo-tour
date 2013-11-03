module demo

#Pour lancer : golo golo --files 01.golo

import java.lang.String


function main = |args| {

	println("Hello Montpellier!")

	println("""

		=== Prez Golo ===

		@MontpellierJUG

	""")

	println(
		"My name is %s %s":format("Bob", "Morane")
	)

	println(
		String.format("My name is %s %s", "Bob", "Marley")
	)

}

