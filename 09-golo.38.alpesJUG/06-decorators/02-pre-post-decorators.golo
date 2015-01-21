module yapasdetypesmaiscestpasgrave

import gololang.Decorators

let isPositive = |v| {
  require(v > 0, v + "is not > 0")
  return v
}

# it's a checker
let isInteger = |value| {
  require(value oftype Integer.class, value + " is not an Integer")
  return value
}
# let isInteger = isOfType(Integer.class)

@checkResult(isInteger)
@checkArguments(isInteger, isInteger)
function addOnlyIntegers = |a, b| {
  return  a + b
}

@checkArguments(isInteger: andThen(isPositive))
function inv = |v| -> 1.0 / v

function main = |args| {
  addOnlyIntegers(2,3)
  inv(3)
}