module molossol

# function `describe` arguments: title, suite (anonymous function)
# describe runs suite of specifications
# ...
function describe = |title, suite| {
  println(title)
  suite()
}

# function `it` "specifications" arguments: title, specification (anonymous function)
# it runs specification (set of expectations)
# ...

function it = |title, specification| {
  println(title)
  specification()
}


# matchers : structure with actualValue
struct matchers = { actualValue }

# matchers augmentation with comparison(s) : toEqual
# ...
augmentation Equal = {
  function toEqual = |this, expectedValue| {
    # contract
    require(
      this: actualValue(): equals(expectedValue), 
      "!!! " + this: actualValue() + " not condition " + expectedValue
    )
    # all is fine
    println("OK: " + this: actualValue() + " condition " + expectedValue)
  }
} 
augment molossol.types.matchers with Equal

# expect (expectation) return matchers and set actualValue

function expect = |value| {
  return matchers(): actualValue(value)
}


