module demo

import acme.Toon # déclarer toons

# méthode d'instance
# getter / setter
# méthode statique

function main = |args| {
  let Elmira = Toon("Elmira")
  println(Elmira: name())
  Elmira: name("ELMIRA")
  println(Elmira: name())

  let Buster = Toon.getInstance("Buster")
  Elmira: hug(Buster)

}
