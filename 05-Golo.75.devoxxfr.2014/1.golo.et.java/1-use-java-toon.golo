module demo

import acme

function main = |args| {

  let buster = Toon("Buster") # new

  println(buster: name()) # property (getter)

  buster: name("BUSTER") # setter

  buster: hello()

  let babs = Toon.getInstance("Babs")

  println(babs: name())

}

# golo golo --classpath jars/*jar --files main.golo