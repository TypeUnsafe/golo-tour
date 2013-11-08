module experiments

import org.k33g.alien.adapters # <- this my little adapter DSL

import acme.Toon
import acme.Elmira

augment acme.Toon {
  function tadaaa = |this| {
    println("tadaaa : " + this: name())
  }
} 

function main = |args| {

  let Toon = Adapter(): extends("acme.Toon")
    :interfaces(["acme.iMegaToon", "acme.iSuperToon"])
    :implements(
      methods()
        :hi(|this|-> println("HI..."))
        :knock(|this|-> println("KNOCK KNOCK..." + this:name()))
        :pouet(|this|-> println("pouet pouet..."))
        :clap(|this|-> println("clap clap..."))
    )
    :overrides(
      methods()
        :sayHello(|super, this| {
          println("sayHello method from %s":format(this:name()))
        })
        :scream(|super, this| {
          println("scream method from %s":format(this:name()))
        })
    )

  Elmira.love(Toon: make(): newInstance(): name("Buster"))
  Elmira.talk(Toon: make(): newInstance(): name("Babs"))

  let Taz = Toon: make(): newInstance("Taz")

  Taz: tadaaa()
  Taz: sayHello()
  Taz: knock()
  Taz: clap()

}