module demo

#./g.sh libs 01-toons.golo

import acme.Toon
import acme.Elmira
import acme.iToon

function main = |args| {
	
	let toon = Toon()

	println(toon:hello())
	println(toon:scream())

	#conversion to single-method interfaces
	let babs = (-> "Hi i'm Babs Bunny, please help me!"):to(iToon.class)

	#Static
	Elmira.love(babs)


}

