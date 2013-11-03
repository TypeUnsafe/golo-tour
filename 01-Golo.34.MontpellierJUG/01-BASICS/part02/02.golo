module demo

function main = |args| {
	
	let add = |a, b| -> a + b
	let x5 = |a| -> a * 5

	let all = x5:andThen(add)

	println(
		all(5,6)
	)

}