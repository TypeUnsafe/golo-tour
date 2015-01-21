module firstcode
# function add 
# lambda multiply

function add = |a, b| {
  return a + b
}

function multiply = |a, b| -> 
  a * b

function main = |args| {
  println(add(2,3))
  println(multiply(3,4))
  
}