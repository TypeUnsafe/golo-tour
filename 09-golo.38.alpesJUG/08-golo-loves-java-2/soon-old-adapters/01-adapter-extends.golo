module demo_adapters

import acme

function main = |args| {

  let toonDefinition = map[
    ["extends", "acme.Toon"],
    ["implements", map[
      ["yo", |this| {
          println(this: name() + " : YO!" )
      }],     
      ["hello", |this, message| {
          println("hello from " + this: name() + " : " + message)
      }]                 
    ]]
  ]

  let buster = AdapterFabric(): maker(toonDefinition)
    : newInstance("Buster Bunny")

  buster: yo()
  buster: hello("Salut!!!")
  
}