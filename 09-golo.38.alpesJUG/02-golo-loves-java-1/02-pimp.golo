module paysacme

import acme.Toon
# ajouter une méthode bonjour

augmentation hi  = {
  function bonjour = |self, message| {
    println(self: name() + ": Bonjour " + message)
  }
}

augment acme.Toon with hi


function main = |args| {
  let babs = Toon("Babs Bunny")
  babs: bonjour("salut")
}
