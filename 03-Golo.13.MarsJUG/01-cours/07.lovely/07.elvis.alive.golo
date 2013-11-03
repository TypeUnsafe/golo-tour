module elvis

function main = |args| {
 
  let human = DynamicObject():lastName("Morane")

  # if !exists then null
  println(human?: name() orIfNull "--NULL--")
}