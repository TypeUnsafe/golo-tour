module tinyToons

import acme.Toon

augment acme.Toon {

	function hug = |this, toon| {
		println(this:name() + " ♥ ♥ ♥ " + toon:name())
	}
} 

function main = |args| {

	let buster = Toon():name("Buster")
	let babs = Toon():name("Babs")

	babs:hug(buster)

}