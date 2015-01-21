module playtoons

import gololang.Adapters
import acme.Toon

function GoloToon = |name| {

  let toonAdapter = Adapter()
    : interfaces(["acme.iToon"])
    : implements("hello", |this, message| {
        println(message)
      })
    : implements("yo", |this| {
        println("yo!")
      })
    : implements("getName", |this| {
        return name
      })

  return toonAdapter: newInstance()

}

function main = |args| {
  
  let babs = GoloToon("Babs Bunny")

  let elmira = Toon("Elmira")

  elmira: hug(babs)

}