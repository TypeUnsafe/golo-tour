module closures_et_lambda

function main = |args| {

	let addition = |a, b| -> a + b

	let x5 = |a| -> a * 5

	let additionX5 = x5:andThen(addition)

	println(additionX5(5,5))

  # inverse possible
}