module strudemo

struct human = { 
  firstName,
  lastName
}
augment human {
  function initializer = |this| {

    return this;
  }
  function hello = |this| {
    println("Salut " + this: firstName() + 
      this: lastName()
    )
  }
} 

#to do augmentation hero = {}


function main = |args| {
  let clark = human("clark", "kent")
  println(clark)
  clark: hello()
# augment, augmentation
}