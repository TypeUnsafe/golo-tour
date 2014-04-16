module demo_dynamic

function main = |args| {

  let somebody = DynamicObject()
    : define("who", |this, name| {
        println("Je m'appelle " + name)
        return this
    })
    : define("hero", |this, name| {
        println("Je suis " + name)
        return this
    })
    : define("power", |this, power| {
        println("Je sais " + power)
        return this
    })

  somebody: who("Tony Stark"): hero("IronMan"): power("voler")

  somebody: hero("IronMan"): power("voler"): who("Tony Stark")

}


