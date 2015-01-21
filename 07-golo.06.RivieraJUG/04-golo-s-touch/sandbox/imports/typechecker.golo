module typechecker

struct checkResult = {
  expected,
  found,
  result
}

function checkType = |t| -> |v| -> checkResult(t: getName(), v: getClass(): getName(), v oftype t)
function isInteger = -> checkType(Integer.class)
function isDouble = -> checkType(Double.class)

function check = |paramsTypeTesters...| {

  return |returnValueTypeTester| {
    return |func| {
      return |args...| {
        paramsTypeTesters: size(): times(|index| {
          let test = paramsTypeTesters: get(index)(args: get(index))
          require(
            test: result(),
            "\nParameter " + args: get(index) + " is not of required type!" +
            "\nExpected " + test: expected() +
            "\nFound " + test: found()
          )
        })
        let res = func: invokeWithArguments(args)
        let test = returnValueTypeTester(res)
        require(
          test: result(),
          "\nReturn value " + res + " is not of required type!" +
          "\nExpected " + test: expected() +
          "\nFound " + test: found()
        )
        return res
      }
    }
  }
}
