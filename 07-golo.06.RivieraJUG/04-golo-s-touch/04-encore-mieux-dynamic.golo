module dynamic_objects

function main = |args| {
  
  let clark = DynamicObject()
    : name("Clark Kent")
    : define("hello", |this| {
        println("hello I'm " + this: name())
      })

  clark: hello()

  clark: define("salut", |this| {
    println("salut je suis " + this: name())
  })

  clark: salut()

  let superMan = DynamicObject(): mixin(clark)
    : heroName("Super Man")
    : define("hello", |this| {
        println("hello I'm " + this: name() +
          " and " + this: heroName()
        )
      })

  superMan: hello()
  superMan: salut()



}