module demo_adapters

import acme

function main = |args| {

  let toonDefinition = map[
    ["extends", "acme.Toon"],
    ["overrides", map[
      ["yo", |super, this| {
          println("I'm " + this: name())
          super(this)
          println("I'm Happy")
      }],
      ["hello", |super, this, message| {
          super(this, message)
      }]             
    ]]
  ]

  let buster = AdapterFabric(): maker(toonDefinition)
    : newInstance("Buster Bunny")

  buster: yo()
  buster: hello("Salut!")
}