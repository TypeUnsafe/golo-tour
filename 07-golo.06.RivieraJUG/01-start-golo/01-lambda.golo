module prog
#add multiply / function & lambda

function add = |a,b| {
  return a + b
}

function main = |args| {
  let multiply = |a,b| -> a *b 

  println(add(5,6))
  println(multiply(5,6))
  

}