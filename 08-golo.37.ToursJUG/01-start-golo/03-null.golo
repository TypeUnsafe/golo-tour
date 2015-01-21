module allisnotnull

# orIfNull

function main = |args| {
  
  let a = null
  let b = a orIfNull 12
  println(b)

}