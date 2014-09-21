module demo

import acme.Toon # déclarer toons

function main = |args| {
  
  let buster = Toon("Buster") # pas de new

  buster: hello("salut") # : pour appeler une méthode d'instance

  println(buster: name()) # getter / accéder au "champs"
  buster: name("Buster Bunny") # setter / accéder au "champs"

  buster: hello("hi!")

  let babs = Toon.getInstance("Babs") # statique

  babs: hello("Ola!")

}
