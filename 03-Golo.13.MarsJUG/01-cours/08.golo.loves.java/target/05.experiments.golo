module adapters

import acme.Toon
import acme.Elmira
import acme.iToon
import acme.iTinyToon


function runnable = {

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
  let runner = AdapterFabric(): maker(conf): newInstance()
  runner: hi()
  runner: hello()
  
}



function main = |args| {
  runnable()
}