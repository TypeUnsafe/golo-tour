module humanize_adapters_with_structure

import acme
import humanize.adapters.with.structure

function main = |args| {

  let toonDefinition = Adapter(): extends("acme.Toon")
    : implements("yo", |this| -> println(this: name() + " : YO!" ))
    : implements("hello", |this, message| -> println("hello from " + this: name() + " : " + message))
    : definition()

  let buster = AdapterFabric(): maker(toonDefinition)
    : newInstance("Buster Bunny")

  buster: yo()
  buster: hello("Salut!!!")

  
}