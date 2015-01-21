module fringe_division

function main = |args| {
  let olivia = Observable("olivia")

  let december = |value| { # thread-safe
    println("[December]: Olivia has changed is name: "+ value)
  }

  let november = |value| { # thread-safe
    println("[November]: Olivia has changed is name: "+ value)
  }

  olivia: onChange(december)
  olivia: onChange(november)

  #olivia: set("Olivia")
  #olivia: set("OLIVIA")

}