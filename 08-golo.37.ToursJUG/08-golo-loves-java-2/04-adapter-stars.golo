module demo_adapters

import acme

function main = |args| {

  let toonDefinition = map[
    ["extends", "acme.Toon"],
    ["overrides", map[
      ["*", |super, name, args| { # this = args: get(0)
          println(
            "method name: " + name + 
            ", arguments: " + args: asList(): tail()
          )
          return super: invokeWithArguments(args)
      }]      
    ]]
  ]

  let buster = AdapterFabric(): maker(toonDefinition)
    : newInstance("Buster")

  buster: yo()
  buster: hello("Salut")
}