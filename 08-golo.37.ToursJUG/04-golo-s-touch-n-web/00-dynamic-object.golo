module dyno
# clarkent

function main = |args| {
  
  let clark = DynamicObject()
    : firstName("Clark")
    : lastName("Kent")
    : define("hi", |this| {
        println(this: firstName() + " " +
          this: lastName()
        )
      })

clark: hi()

println(clark: firstName())
  
  let hero = DynamicObject()
    : nickName("SuperMan")

clark: mixin(hero)

println(clark: nickName())


#mixin
}