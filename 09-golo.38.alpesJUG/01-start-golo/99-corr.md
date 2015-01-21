#01-lambda and co

	module firstcode
	# function add 
	# lambda multiply
	# andThen : x = x * 2, x = x + 2
	# (a)(b)(c) x = a * (b+c) 
	# bindTo

	function add = |a,b| {
	  return a + b
	}

	function main = |args| {

	  let multiply = |a,b| -> a *b 

	  println(add(5,6))
	  println(multiply(5,6))

	  let mult2add2 = (|a|-> multiply(a,2)): andThen(|a|-> add(a,2))

	  println(mult2add2(10))

	  let addThenMultiply = |a| -> |b| -> |c| -> multiply(a, add(b,c))

	  println(addThenMultiply(5)(4)(2))

	  let mult5 = multiply: bindTo(5)
	  println(mult5(10))

	  let sam = |args...| {
	    println("from sam " + JSON.stringify(args))
	  }

	  let bob = |args...| {
	    println("from bob " + JSON.stringify(args))
	    sam(args)
	  }

	  bob(4,3,1)
	}

#02-boucles conditions

	module boucles
	#times while foreach if

	function main = |args| {

	  5: times(|index|->println(index))

	  var c = 0
	  while c < 5 {
	    println(c)
	    c = c + 1
	  }

	  foreach (item in [1,2,3,4]) {
	    println(item)
	  }
	  
	  if c is 5 {
	    println("c==5")
	  }

	}

#Null

	module allisnotnull

	function main = |args| {
	  
	  let b = 5

	  let a = b orIfNull 12

	  println(a)

	}


