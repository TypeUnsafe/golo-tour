module demo

import java.util.HashMap

function main = |args| {
	
	let books = HashMap() #new
		:add(1, "A Princess of Mars")
		:add(2, "The Gods of Mars")
		:add(3, "The Chessmen of Mars")

	books:each(|key, value| {
	   println(key+" "+value)
	})

	println(
		books:filter(|key, value| {
			return key == 3
		})
	)

	println(
		books:filter(|key, value| {
			return value is "The Gods of Mars"
		})
	)

}