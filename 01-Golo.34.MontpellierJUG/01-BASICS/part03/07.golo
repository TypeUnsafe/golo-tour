module eval

function main = |args| {
	let env = gololang.EvaluationEnvironment()
	let code =
	"""
	module foo

	function add = |a,b| {
		return a + b
	}

	function sub = |a,b| -> a - b

	"""
	let mod = env: asModule(code)
	
	let add = fun("add", mod) #fun get a ref on ...
	let sub = fun("sub", mod)
	
	println(add(4,5))
	println(sub(10,6))
}