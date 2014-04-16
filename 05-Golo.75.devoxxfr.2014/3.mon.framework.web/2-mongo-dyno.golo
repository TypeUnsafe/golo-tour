module demo_mongodb

import humans.mongodb.models
import mongodb

function main = |args| {

  # new collection
  let humans = Humans()

  # get and create new models
  let bob = humans: model()
    : setName("Bob Morane")
    : setAge(38)
    : insert()
    
  let bill = humans: model(): setName("Bill Ballantine"): setAge(45): insert()
  let ylang = humans: model(): setName("Miss Ylang-Ylang"): setAge(27): insert()
  let ombre = humans: model(): setName("Ombre Jaune"): setAge(99): insert()


  # get all
  humans: fetch(): each(|human| -> println("(all)- " + human))

  # descending sort
  humans: sort(["name", -1]): fetch(): each(|human| ->
    println("(sorted)- " + human)
  )

  humans: query(Qb("age"): lessThan(39): get())
    : each(|human| -> println("(39)- " + human))

}






