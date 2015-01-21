module strudemo

# struct (human-> clark) augment, augmentation

struct Human = { 
  firstName,
  lastName
}

augment Human {
  function hello = |this| -> println("Hello " + this: firstName() +
     this: lastName())
  function hello = |this, message| -> println(message)
}


function main = |args| {

  let clark = Human(): firstName("Clark"): lastName("Kent")

  println(clark: members())

  # regarder si on peut parcourir les méthodes

}