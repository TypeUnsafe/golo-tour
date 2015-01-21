module paysacme

import acme.Toon # déclarer toons du jar

# instance d'Elmira
# changer le nom d'Elmira
# Elmira dit hello (méthode d'instance)
# instance de Buster : (getInstance) méthode statique
# hug Buster

function main = |args| {

  let Elmira = Toon("Elmira")
  println(Elmira: name())

  Elmira: name("ELMIRA")
  println(Elmira: name())

  Elmira: hello("Salut")

  let Buster = Toon.getInstance("Buster")

  Elmira: hug(Buster)






}