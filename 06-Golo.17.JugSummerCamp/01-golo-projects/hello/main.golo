module hello

function hello = |who| {
  println("Hello " + who)
}

function main = |args| {

  let salut = |qui| -> println("Salut " + qui) # closure

  salut("John")

  hello("Bob") 

}