module firstcode
# function add 
# lambda multiply
# andThen @1
# function that return functions @2
# bindTo @3
# args...

function add = |a, b| {
  return a + b
}


function main = |args| {

  let f = (|x| -> x*2): andThen(|x| -> x+2)
  println(f(3))

  let f1 = |x| -> |y| -> |z| -> x*y+z

  println(
    f1(2)(3)(4)
  )

  let add = |a,b| -> a+b
  
  let addTen = add: bindTo(10)





  let multiply = |a, b| -> a * b

  println(multiply(5,6))

  println(add(5,6))

}