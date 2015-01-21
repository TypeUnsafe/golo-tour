module dyno
# clarkent
# mixin

# constructor Human

function Human = |first, last| {

  return DynamicObject()
    : firstName(first)
    : lastName(last)
    : hello(|this| { # define ?
        println("Hello, I'm " + this: firstName())
      })    
}

function main = |args| {

  let clarkent = Human("Clark", "Kent")

  let superMan = DynamicObject(): power("fly")

  clarkent: mixin(superMan)

  println(clarkent: power())
  clarkent: hello()


}