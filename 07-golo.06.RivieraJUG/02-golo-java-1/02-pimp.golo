module demo

import acme.Toon

augment acme.Toon {
  function salut = |self, message| {
    println(self: name() + " : " + message)
  }
}

function main = |args| {
  let babs = Toon("Babs")
  babs: salut("Hello")
}
