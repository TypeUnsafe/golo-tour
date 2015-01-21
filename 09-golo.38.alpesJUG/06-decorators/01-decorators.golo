module decorators

#decorate function with function

# add log decorator
function log = |decoratorArgs...| {
  return |func| { # return decorated function
    return |functionArgs...| {
      println(
        "log "+ decoratorArgs: get(0) 
        + " " + decoratorArgs: get(1))
      return func: invokeWithArguments(functionArgs)
    }
  }
}

@log("ADD", "hello")
function add = |a, b| {
  return  a + b
}

@log("MULTIPLYYYYYY7", "hello")
function multiply = |a, b| {
  return a * b
}


function main = |args| {
  add(4, 4)
  multiply(2, 3)
}