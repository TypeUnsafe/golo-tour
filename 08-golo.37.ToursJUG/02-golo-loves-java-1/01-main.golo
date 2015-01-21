module paysacme

import acme.Toon # déclarer toons du jar

# instance d'Elmira
# changer le nom d'Elmira
# Elmira dit hello (méthode d'instance)
# instance de Buster : (getInstance) méthode statique
# hug Buster

function main = |args| {

  let Elmira  = Toon("ELMIRA")

  println(Elmira: name())
  Elmira: name("Elmira")
  println(Elmira: name())
  Elmira: hello("Salut")

  let buster = Toon.getInstance("buster")
  println(buster: name())

  Elmira: hug(buster)

}