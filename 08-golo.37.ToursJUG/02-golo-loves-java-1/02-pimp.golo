module paysacme

import acme.Toon


augmentation bonjour = {
  function salut = |self, message| {
    println(message + " by " + self: name())
  }
} 
augment acme.Toon with bonjour

function main = |args| {

  let babs = Toon("Babs Bunny")

  babs: salut("Hello Tours")


}
