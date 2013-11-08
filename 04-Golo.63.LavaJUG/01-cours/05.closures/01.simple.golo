module closures_et_lambda

function add = |a, b| -> a + b

function main = |args| {
	
	let addition = |a, b| {
		return a + b
	}

	# implicit return (valable pour les fonctions)
	let additionBis = |a, b| -> a + b


	println(add(5,7))	
	println(additionBis(5,7))

}