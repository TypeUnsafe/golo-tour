module pimp_my_struct

struct human = {
  firstName, lastName
}
augment human {
  function hello = |this| {
    println(
      "Hello from " + this: firstName() 
      +  " " + this: lastName()
    )
  }
} 


function main = |args| {

  let bob = human("Bob", "Morane")
  let john = human()
  john: firstName("John"): lastName("Doe")

  bob: hello()
  john: hello()
}
