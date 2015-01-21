module demo_adapters

import acme

function main = |args| {
  let name = "Babs"

  let toonDefinition = map[
    ["interfaces", ["acme.iToon"]],
    ["implements", map[
      ["yo", |this| {
          println(this: getName() + " : YO!" )
      }],           
      ["hello", |this, message| {
          println("hello from " + this: getName() + " : " + message)
      }],         
      ["getName", |this| {
          return name
      }]                            
    ]]
  ]

  let babs = AdapterFabric(): maker(toonDefinition)
    : newInstance()

  babs: yo()
  babs: hello("coucou")

  let Elmira = Toon("Elmira")
  Elmira: hug(babs)

}