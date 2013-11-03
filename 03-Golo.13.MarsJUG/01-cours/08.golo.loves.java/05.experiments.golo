module adapters

import acme.Toon
import acme.Elmira
import acme.iToon
import acme.iTinyToon


function giveMeAToon = {

  let conf = map[
    ["interfaces", ["acme.iTinyToon"]],
    ["implements", map[
      ["hi", |this| {
        println("HI")
      }],
      ["hello", |this| {
        println("HELLO")
      }]      
    ]]
  ]
  let toon = AdapterFabric(): maker(conf): newInstance()

  return toon
  
}

function main = |args| {
  Elmira.talk(giveMeAToon())
}