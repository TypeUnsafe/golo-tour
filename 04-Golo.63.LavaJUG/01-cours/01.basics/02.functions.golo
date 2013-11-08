module fonctions

function hello = |name| {
	return "hello %s":format(name)
}

function salut = |args...| {
	println("Salut " + args:get(0) + " " + args:get(1))
}

function main = |args| {
	println( hello("Bob Morane") )

	salut("Bob", "Morane")
}