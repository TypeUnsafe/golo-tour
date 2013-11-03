module closures_et_lambda

function main = |args| {
	
	let addition = |a, b| {
		return a + b
	}

	# implicit return (valable pour les fonctions)
	let additionBis = |a, b| -> a + b


	println(addition(5,7))	
	println(additionBis(5,7))

}