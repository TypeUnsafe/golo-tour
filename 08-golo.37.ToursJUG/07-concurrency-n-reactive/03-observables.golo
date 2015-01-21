module fringedivision

function main = |args| {
  # --- observables ---

  let olivia = Observable("Olivia")

  let december = |value| {
    println("december: " + value)
  }

  let november = |value| {
    println("november: " + value)
  }

  olivia: onChange(december):onChange(november)

  olivia: set("OLIVIA")
}