module allisnotnull

# orIfNull

function main = |args| {
  
  let b = 2
  let a = b orIfNull 12
  println(a)
}