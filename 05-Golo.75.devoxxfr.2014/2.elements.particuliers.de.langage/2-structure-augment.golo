module demo_structure

struct human = {
  firstName, lastName
}

augment human {
  function hello = |this| -> 
    println("Hello " + this: firstName() + " " + this: lastName())
}

function main = |args| {
  let bob = human("bob", "morane")
  bob: hello()
}
