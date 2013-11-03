module extjars

#./g.sh libs 02-toons.golo

import acme.Toon
import acme.Elmira
import acme.iToon

augment acme.Elmira {
	function hug = |this, toon| {
		toon:talk()
	}
}

augment acme.Toon {
	function talk = |this| {
		println(this:name()+" : I'm talking")
	}
}

function main = |args| {

	let elmira = Elmira()
	let buster = Toon()

	buster:name("Buster")

	elmira:hug(buster)

}

