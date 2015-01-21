module fringe_division

function main = |args| {

  let olivia = Observable("Olivia")

  let december = |value| -> println("(december)Changed: " + value)
  let november = |value| -> println("(november)Changed: " + value)

  olivia: onChange(december): onChange(november)

  olivia: set("OLIVIA")
  

}