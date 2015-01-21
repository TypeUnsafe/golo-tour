module decorators

#decorate function with function

# add log decorator
# ...
function log = |decoratorArgs...| {
  return |func| { # return decorated function
    return |functionArgs...| {
      println(JSON.stringify(decoratorArgs))
      println(JSON.stringify(functionArgs))

      return func: invokeWithArguments(functionArgs)
    }
  }
}


@log("add","ligne 20")
function add = |a, b| {
  return  a + b
}
@log("multiply","ligne 24")
function multiply = |a, b| {
  return a * b
}


function main = |args| {
  add(4, 4)
  multiply(2, 3)
}