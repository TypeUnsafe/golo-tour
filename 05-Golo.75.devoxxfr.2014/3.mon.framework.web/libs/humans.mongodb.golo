module humans.mongodb.models

import mongodb

# Collection
function Humans = {
  let dbCollection = Mongo(): database("demodb_devoxx_02"): collection("humans")
  # Model
  let humanModel = |db_collection| ->
    MongoModel(db_collection)
      : define("setName", |this, name| {
          this: setField("name", name)
          return this
      })
      : define("getName", |this| -> this: getField("name"))
      : define("setAge", |this, age| {
          this: setField("age", age)
          return this
      })
      : define("getAge", |this| -> this: getField("age"))

  # Collection
  let humansCollection = MongoCollection(humanModel , dbCollection)

  # Add methods to collection

  return humansCollection
}