module models.toon

import m33ki.mongodb

# Collection
function Toons = {
  let collection = Mongo()
    : database("toonsdb")
    : collection("Toons")
  # Model
  let Toon = |collection| -> MongoModel(collection)

  return MongoCollection(Toon, collection)
}

