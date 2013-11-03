module closures_et_lambda

function main = |args| {

	let addition = |a, b| -> a + b

	let x5 = |a| -> a * 5

	let additionX5 = addition:andThen(x5)

	println(additionX5(5,5))

  # inverse possible
}