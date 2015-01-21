#Golo loves java (I)

##main

	module paysacme

	import acme.Toon # déclarer toons du jar

	# instance d'Elmira
	# changer le nom d'Elmira
	# Elmira dit hello (méthode d'instance)
	# instance de Buster : (getInstance) méthode statique
	# hug

	function main = |args| {

	  let Elmira = Toon("ELMIRA")
	  Elmira: name("Elmira")
	  Elmira: hello("Salut")

	  let Buster = Toon.getInstance("Buster")
	  
	  Elmira: hug(Buster)

	}

##pimp

	module paysacme

	import acme.Toon

	# ajouter une méthode salut à acme.Toon

	augment acme.Toon {
	  function salut = |this, message| {
	    println(this: name() + " : " + message)
	  }
	}

	function main = |args| {
	  let babs = Toon("Babs")
	  babs: salut("Hello")
	}
