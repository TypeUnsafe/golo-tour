module dynamic_objects_ala_javascript

function Human = |firstName, lastName| {
  
  return DynamicObject(): firstName(firstName)
    : lastName(lastName)
    : define("toString", |this| {
      return this: firstName() + "  " + this: lastName()
    })
}

function main = |args| {
  let clark = Human("clark", "kent")
  println(clark: toString())
}