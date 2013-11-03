module demo


function choice = |food| {
	case {
		when food is "vegetable" { println("good") }
		when food is "fruit" { println("good") }
		otherwise { println("bad") }
	}

}

function chooseYourWay = |route| {
	let controller = match {
		when route:startsWith("/users/") then "Users Controller"
		when route:startsWith("/articles/") then "Articles Controller"
		otherwise "404"
	}
	return controller
}

function main = |args| {

	choice("vegetable")
	choice("fruit")
	choice("steak")
	

	println(chooseYourWay("/use_rs/toto"))
	println(chooseYourWay("/users/toto"))
	println(chooseYourWay("/users/tata"))
	println(chooseYourWay("/articles/12"))


}
