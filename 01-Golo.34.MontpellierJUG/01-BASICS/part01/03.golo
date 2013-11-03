module demo

#Pour lancer : 
# golo golo --files libs/mylib.golo 03.golo

import mylib

function hello = |name| {
	return "Hello " + name + " ! (from local)"
}

function main = |args| {
	println(mylib.hello("Bob"))
	println(hello("Bob"))
}

