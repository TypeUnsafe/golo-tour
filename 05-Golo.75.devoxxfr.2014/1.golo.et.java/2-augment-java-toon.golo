module demo

import acme

augment acme.Toon {
  function salut = |this| {
    println("Salut, je suis " + this: name())
  }
}

function main = |args| {

  let babs = Toon("Babs")

  babs: salut()

}
