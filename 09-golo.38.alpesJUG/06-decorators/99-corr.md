#Decorators

function log = |decoratorArgs...| {
  return |func| { # return decorated function
    return |functionArgs...| {
      println("log: " + JSON.stringify(decoratorArgs))
      println("args: " + JSON.stringify(functionArgs))

      let ret = func: invokeWithArguments(functionArgs)

      println("result: " + ret)
      return ret
    }
  }
}

@log("call add", "line 14")
function add = |a, b| {
  return  a + b
}

@log("call multiply", "line 18")
function multiply = |a, b| {
  return a * b
}