module humanize_adapters_with_structure_and_decorators

import acme
import humanize.adapters.with.decorators


@extends("acme.Toon")
@implements("yo", |this| {
  println(this: name() + " : YO!" )
})
@implements("hello", |this, message| {
  println(message)
})
@implements("getName", |this| {
  return this: name()
})

function toon = |adapter| -> adapter : class()


function main = |args| {

  let buster = toon(Adapter()): newInstance("Buster Bunny")

  buster: yo()
  buster: hello("Salut!!!")

  let Elmira = Toon("Elmira")
  Elmira: hug(buster)

}