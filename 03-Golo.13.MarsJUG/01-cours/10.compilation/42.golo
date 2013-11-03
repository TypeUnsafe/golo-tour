module org.fortytwo.H2G2

#formule de Wallis (1616-1703 Anglais)

function calculatePi = |precision| {
	var increment2 = 2.0
	var resultat = 1.0
	for (var increment = 1.0, increment <= precision, increment = increment + 2)  {
		resultat = resultat * (increment2/increment)
		if increment == (increment2+1) {
			increment2 = increment2+2.0
			increment = increment - 2.0
		}
	}
	return 2 * resultat
}

function main = |args| {
	let start = java.lang.System.currentTimeMillis()
	println(calculatePi(20000000.0))
  println(java.lang.System.currentTimeMillis() - start)
	
}
