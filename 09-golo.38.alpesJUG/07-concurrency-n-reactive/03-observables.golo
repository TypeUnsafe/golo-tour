module fringedivision

function main = |args| {
  # --- observables ---
  # december, november

  let olivia = Observable("Olivia")

  let december = |value| {    
    println("December: " + value)
  }

  let november = |value| {
    println("November: " + value)
  }

  olivia: onChange(december): onChange(november)

  olivia: set("Olivia")




}