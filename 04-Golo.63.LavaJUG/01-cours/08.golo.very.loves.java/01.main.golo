module tinyToons

import acme.Toon
import acme.Elmira

function main = |args| {
	
  let buster = Toon() # no new
	buster:name("Buster") # instance method

	buster:scream()

	Elmira.love(buster) # static (class method)
}