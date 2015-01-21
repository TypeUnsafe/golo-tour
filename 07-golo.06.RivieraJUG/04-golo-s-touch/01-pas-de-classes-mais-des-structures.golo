module les_structures

# Human 
struct human = { 
  firstName,
  lastName
}

function main = |args| {
  let bob = human("Bob", "Morane")
  let john = human()
  john: firstName("John"): lastName("Doe")

  println(bob)
  println(john)

}