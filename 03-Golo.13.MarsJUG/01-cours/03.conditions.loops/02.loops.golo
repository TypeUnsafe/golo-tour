module loops

function main = |args| {
	
	# while
	var i = 1
	while i <= 5 { 
		println("-> " + i)
		i = i + 1
	}

	# fornext
	for(var i = 1, i <= 5, i = i + 1) {
		println("=> " + i)	
	}

	# foreach
	let books = array[
		"A Princess of Mars",
		"The Gods of Mars",
		"The Chessmen of Mars"
	]

	foreach book in books { println(book) }

}