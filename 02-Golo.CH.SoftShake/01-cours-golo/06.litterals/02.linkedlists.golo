module linkedlists

function main = |args| {
	
	let bookslist = list[
			"A Princess of Mars"
		, "The Gods of Mars"
		, "The Chessmen of Mars"
	]

	bookslist:each(|book|-> println("- " + book))

	println("Reversed BooksList : " + bookslist:reverse())

	println("Filtered BooksList : " + 
		bookslist:filter(|book|-> book != "The Gods of Mars")
	)

}