module demo

import acme

function main = |args| {

  let toonDefinition = map[
    ["extends", "acme.Toon"],
    ["overrides", map[
      ["hello", |super, this| {
          println("Avant ...")
          super(this)
          println("... Après")
      }]
    ]]
  ]

  let buster = AdapterFabric(): maker(toonDefinition)
    : newInstance("Buster Bunny")

  buster: hello()
}