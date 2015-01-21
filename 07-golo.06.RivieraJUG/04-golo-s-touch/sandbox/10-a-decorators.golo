module decorators_demo

function something = |decoratorArgs...| {
  return |func| { # retourne la fonction décorée
    return |functionArgs...| {
      println("decoratorArgs: " + JSON.stringify(decoratorArgs))
      println("functionArgs: " + JSON.stringify(functionArgs))
      
      return func: invokeWithArguments(functionArgs)
    }
  }
}

@something("one", "two", "three")
function hello = |message| {
  println("hello " + message)
}


function main = |args| {
  hello("world")
}