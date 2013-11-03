module hashmaps

function main = |args| {
	
	let books = map[ # [key,value]
			[1, "A Princess of Mars"]
		, [2, "The Gods of Mars"]
		, [3, "The Chessmen of Mars"]
	]

	books:each(|key, value| {
	   println(key+" "+value)
	})

	println(
		books:filter(|key, value| {
			return key == 3
		})
	)
}