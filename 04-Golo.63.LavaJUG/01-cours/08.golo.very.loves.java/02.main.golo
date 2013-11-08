module tinyToons

import acme.Toon
import acme.Elmira
import acme.iSimpleToon

function main = |args| {
	
  let buster = Toon() # no new
  buster:name("Buster") # instance method
  Elmira.whoAreYou(buster) # static (class method)


	#conversion to single-method interfaces
	let babs = {
		println("Heeellllp i'm Babs Bunny, please help me!")
	}:to(iSimpleToon.class)

	Elmira.whoAreYou(babs) # static (class method)
}