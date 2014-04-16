module demo

import acme

function main = |args| {

  let toonDefinition = map[
    ["extends", "acme.Toon"],
    ["implements", map[
      ["hello", |this| {
          println("Salut, je suis " + this: name())
      }]
    ]]
  ]

  let buster = AdapterFabric(): maker(toonDefinition)
    : newInstance("Buster Bunny")

  buster: hello()
}