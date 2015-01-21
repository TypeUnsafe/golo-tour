module playtoons

import gololang.Adapters


function GoloToon = |name| {

  let toonAdapter = Adapter()
    : extends("acme.Toon")
    : overrides("hello", |super, this, message| {
        println("--- Before ---")
        super(this, message)
        println("--- After ---")
      })

  return toonAdapter: newInstance(name)

}

function main = |args| {
  
  let babs = GoloToon("Babs Bunny")

  babs: hello("Bonjour!")

}