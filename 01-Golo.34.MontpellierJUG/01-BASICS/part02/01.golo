module demo

function main = |args| {
	
	let add = |a,b| {
		return a+b
	} 

	let substract = |a,b| -> a-b

	println(
		add(4,substract(10,5))
	)
}