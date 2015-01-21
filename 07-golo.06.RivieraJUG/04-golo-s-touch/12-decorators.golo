module decorators

#
function decor = |arg| {
  return |func| { # return decorated function
    return |a, b| {
      return func
        : invokeWithArguments(a + arg, b + arg)
    }
  }
}

@decor(5)
function add = |a, b| {
  return a + b
}

function main = |args| {
  println(add(5,5))
}