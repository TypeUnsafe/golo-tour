module tinyToons

import acme.Toon

augment acme.Toon {
	function say = |this, something| {
		println(this:name() + " " + something)
	}
	function hug = |this, toon| {
		toon: say("♥ ♥ ♥ " + this:name())
	}
} 

function main = |args| {

	let buster = Toon():name("Buster")
	let babs = Toon():name("Babs")

	babs:hug(buster)

}