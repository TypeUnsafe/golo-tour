module pimp_the_list

augment java.util.LinkedList {

  function count = |this, pred| -> 
  	this: filter(pred): size()

  function exists = |this, pred| -> 
  	this: filter(pred): size() > 0
}


function main = |args| {

	let bookslist = list[
			"A Princess of Mars"
		, "The Gods of Mars"
		, "The Chessmen of Mars"
	]

	println(
		bookslist:count(|book|->book!="The Gods of Mars")
	)

	println(
		bookslist:exists(|book|->book=="The Gods of Mars")
	)

	println(
		bookslist:exists(|book|->book=="Mars")
	)	

}