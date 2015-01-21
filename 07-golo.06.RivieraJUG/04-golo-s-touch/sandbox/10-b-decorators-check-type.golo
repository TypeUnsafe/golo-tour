module decorators_demo

import typechecker

@check(isInteger(), isDouble()) (isDouble())
function IntPlusDouble = |a,b| {
  return a + b
}

function main = |args| {
  
  let a = IntPlusDouble(5, 6.9)
  println(a)

  let b = IntPlusDouble(5.3, 6.9)
  println(b)
}