module eval

function main = |args| {
  let env = gololang.EvaluationEnvironment()

  let code =
  """
    module my_module

    function Human = |name| {
      return DynamicObject(): name(name)
    }

  """

  let my_module = env: asModule(code) # compile

  let getHuman = fun("Human", my_module) # declare function

  let bob = getHuman("Bob Morane") # use it

  println(bob: name())

}