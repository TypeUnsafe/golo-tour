module linkedlists

function main = |args| {
	let bookslist = list[
			"A Princess of Mars"
		, "The Gods of Mars"
		, "The Chessmen of Mars"
	]

	println("size : " + bookslist:size())
	println("empty : " + bookslist:isEmpty())
	println("head : " + bookslist:head())
	println("tail : " + bookslist:tail())

	println("last : " + bookslist:getLast())
	println("first : " + bookslist:getFirst())

	println("BooksList : " + bookslist)

	println("Reversed BooksList : " + bookslist:reverse())
	println("Reversed BooksList : " + bookslist:reversed())
	#println("BooksList : " + bookslist)

	println("Filtered BooksList : " + 
		bookslist:filter(|book|->book!="The Gods of Mars")
	)

}