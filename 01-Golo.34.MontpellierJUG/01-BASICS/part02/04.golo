module demo

import java.util.LinkedList

function main = |args| {

	let bookslist = LinkedList()
		:append("A Princess of Mars")
		:append("The Gods of Mars")
		:append("The Chessmen of Mars")

	println(
		bookslist:map(|item| {
			return "*-- " + item + " --*"
	})
)

}