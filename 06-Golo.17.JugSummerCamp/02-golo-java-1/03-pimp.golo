module demo

import acme.Toon

augment acme.Toon {

  function message = |this, msg| {
    println(
      msg + " from " + this: name()
    )
  }
}

function main = |args| {
  
  let buster = Toon("Buster")

  buster: message("Hello world!")

}
