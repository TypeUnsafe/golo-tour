module hellomvn

function hello = |who| {
  println("Hello " + who)
}

function main = |args| {

  let salut = |qui| -> println("Salut " + qui) # closure

  salut("John")

  hello("Bob") 

  org.k33g.tools.Hello.message("World!!!")

}