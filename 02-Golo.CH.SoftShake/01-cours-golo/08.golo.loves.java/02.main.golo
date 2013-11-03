module tinyToons

import acme.Toon
import acme.Elmira
import acme.iToon

function main = |args| {
	
	#conversion to single-method interfaces
	let babs = {
		println("Heeellllp i'm Babs Bunny, please help me!")
	}:to(iToon.class)

	Elmira.love(babs) # static (class method)
}