module notation_sympa

function main = |args| {

	let multiplyPoint = |x,y|{
		return |z|-> x * y *z
	}

	println(multiplyPoint(1,2)(3))
	
# handy when you have functions returning functions 
# and you don't want to use intermediate references.

}
