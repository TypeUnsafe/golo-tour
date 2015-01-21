module demo_dynamic


function main = |args| {

  let clarkKent = DynamicObject()
    : firstName("Clark")
    : define("toString", |this| -> 
        "firstName : " + this: firstName()
      )

  println(clarkKent: toString())

  clarkKent: lastName("Kent") 
    : define("toString", |this| ->
        "firstName : " + this: firstName() +
        " lastName : " + this: lastName()
    )

  println(clarkKent: toString())

}


