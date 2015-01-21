module molossol

# describe "suite"  arguments: title, suite (anonymous function)

function describe = |title, suite| {
  println("[Suite]: " + title)
  suite()
}

# it "specifications" arguments: title, specification (anonymous function)

function it = |title, specification| {
  println("[Specification]: " + title)
  specification()
}

# matchers : structure with actualValue
struct matchers = { actualValue }

# augment matchers with comparison(s) : toEqual
augment matchers {
  function toEqual = |this, expectedValue| {
    require(
      this: actualValue(): equals(expectedValue), 
      "!!! " + this: actualValue() + " <> " + expectedValue
    )
    # all is fine
    println("OK: " + this: actualValue() + " == " + expectedValue)
  }
} 

# expect (expectation) return matchers and set actualValue

function expect = |value| {
  return matchers(): actualValue(value)
}


