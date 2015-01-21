module decorators_check_integers

function checkIntegers =  {
  return |func| {
    return |a, b| {
      if (not a oftype Integer.class) or (not b oftype Integer.class) {
        raise("ouch")
      }
      return func: invokeWithArguments(a, b)
    }
  }
}

@checkIntegers()
function add = |a, b| {
  return a + b
}

function main = |args| {
   #println(add(12,32))
   println(add(12.3,32))
}