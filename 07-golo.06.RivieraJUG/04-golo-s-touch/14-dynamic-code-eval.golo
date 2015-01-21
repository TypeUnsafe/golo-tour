module eval

function main = |args| {
  let env = gololang.EvaluationEnvironment()

  let code =
  """
    module my_module

    function Human = |firstName,lastName| {
      return DynamicObject(): firstName(firstName)
        : lastName(lastName)
    }

  """

  let my_module = env: asModule(code) # compile

  let getHuman = fun("Human", my_module) # declare function

  let bob = getHuman("Bob", "Morane") # use it

  println(bob: firstName())
  println(bob: lastName())

}