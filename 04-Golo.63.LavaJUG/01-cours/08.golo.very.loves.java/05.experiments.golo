module adapters

import acme.Elmira

# ex instance de dynamic object qui hériterait de X et implémenterait A, B & C
function giveMeAToon =  {

  let conf = map[
    ["interfaces", ["acme.iToon"]],
    ["implements", map[
      ["sayHello", |this| {
        println("this is sayHello method")
      }],
      ["scream", |this| {
        println("this is scream method")
      }]           
    ]]
  ]
  let toon = AdapterFabric(): maker(conf): newInstance()

  return toon
}

function main = |args| {

  Elmira.love(giveMeAToon())
  Elmira.talk(giveMeAToon())
}