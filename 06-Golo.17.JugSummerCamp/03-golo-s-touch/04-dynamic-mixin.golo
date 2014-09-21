module demo_dynamic

function main = |args| {

  let clarkKent = DynamicObject()
    : firstName("Clark"): lastName("Kent")

  # "héritage fonctionnel"
  let superMan = DynamicObject(): mixin(clarkKent)

  superMan: heroName("SuperMan")
    : power("flying")
    : define("toString", |this| -> "I'm " +
        this: firstName() + " " +
        this: lastName() + " alias " +
        this: heroName() + ", i'm " +
        this: power()
    )

  println(superMan: toString())

}


