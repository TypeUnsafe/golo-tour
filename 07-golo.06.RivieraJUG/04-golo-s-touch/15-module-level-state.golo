module singleton

import santaklaus

function main = |args| {

  let santa1 = getInstanceOfSantaKlaus()

  println(santa1: name())

  santa1: toys(["doll", "dog"])

  let santa2 = getInstanceOfSantaKlaus()

  println(santa2: toys())

  println(santa2 == santa1)

  santa2: toys(["cat", "bird"])

  println(santa1: toys())


}
