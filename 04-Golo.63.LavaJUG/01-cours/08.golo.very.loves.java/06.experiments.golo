module adapters

import acme.Elmira

function giveMeAToon = |name| {

  let conf = map[
    ["extends", "acme.Toon"],
    ["overrides", map[
      ["sayHello", |super, this| {
        println("sayHello method from %s":format(this:name():toString()))
        super(this)
      }],
      ["scream", |super, this| {
        println("scream method from %s":format(this:name():toString()))
        super(this)
      }]           
    ]]
  ]
  let toon = AdapterFabric(): maker(conf): newInstance(name)

  return toon
  
}

function main = |args| {
  Elmira.love(giveMeAToon("Buster"))
  Elmira.talk(giveMeAToon("Babs"))
}