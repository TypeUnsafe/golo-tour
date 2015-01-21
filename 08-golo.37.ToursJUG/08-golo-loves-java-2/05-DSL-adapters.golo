module humanize_adapters_with_structure_and_decorators

    import gololang.Adapters

    function toon = |name| {

      let adapter = Adapter()
        : extends("acme.Toon")
        : overrides("yo", |super, this| {
            super(this)
            println(this: name() + " : YO!" )
          })
        : implements("hello", |this, message| {
            println(message)
          })
        return adapter: newInstance(name)
    }


function main = |args| {

  let buster = toon("Buster Bunny")
  let babs = toon("Babs Bunny")

  babs: yo()

  buster: yo()
  buster: hello("Salut!!!")

  let Elmira = toon("Elmira")
  Elmira: hug(buster)

}