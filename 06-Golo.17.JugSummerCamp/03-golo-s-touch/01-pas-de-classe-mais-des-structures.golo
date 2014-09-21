module demo_structure

struct human = {
  firstName, lastName
}

function main = |args| {

  let bob = human("Bob", "Morane")

  let john = human(): firstName("John"): lastName("Doe")

  println(
    bob: firstName() + " " + bob: lastName()
  )
  println(
    john: firstName() + " " + john: lastName()
  )

}

