module molossol

# function `describe` arguments: title, suite (anonymous function)
# describe runs suite of specifications
# ...

# function `it` "specifications" arguments: title, specification (anonymous function)
# it runs specification (set of expectations)
# ...



# matchers : structure with actualValue
struct matchers = { actualValue }

# matchers augmentation with comparison(s) : toEqual
# ...


augment molossol.types.matchers with Equal

# expect (expectation) return matchers and set actualValue

function expect = |value| {
  return matchers(): actualValue(value)
}


