module demo


function main = |args| {

	#while
	var i = 1
	while i < 10 { 
		println("-> " + i)
		i = i + 1
	}

	#for next
	for(var i = 1, i < 10, i = i + 1) {
		println("=> " + i)	
	}

	#Array
	let books = Array(
		"A Princess of Mars",
		"The Gods of Mars",
		"The Chessmen of Mars"
	)

	#for each (thx @MontpellierJUG ;) )
	foreach book in books {println(book)}

}
