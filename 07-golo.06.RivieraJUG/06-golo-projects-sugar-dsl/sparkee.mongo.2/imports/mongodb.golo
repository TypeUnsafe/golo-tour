module mongodb

import com.mongodb.MongoClient
import com.mongodb.BasicDBObject
import com.mongodb.QueryBuilder


#MongoConf("localhost", 27017, "HumansDb")
let mongoConf = DynamicObject()

function MongoConf = |host, port, dbName| ->
  mongoConf
    : mongoClient(MongoClient(host, port))
    : db(mongoConf: mongoClient(): getDB(dbName))

function MongoCollection = |collectionName| {
  return DynamicObject()
    : collection(mongoConf: db(): getCollection(collectionName))
    : define("find", |this| {
        let models = list[]
        this: collection(): find(): each(|model| {
          let id = model: get("_id")
          model: put("_id", id: toString())
          models: add((model: toMap()))
        })
        return models
      })
}

function MongoModel = |mongoCollection| ->
  DynamicObject()
    : collection(mongoCollection: collection())
    : fields(BasicDBObject())
    : define("set", |this, fieldName, value| {
        this: fields(): put(fieldName, value)
        return this
      })
    : define("get", |this, fieldName| -> this: fields(): get(fieldName))
    : define("insert", |this| {
        let res = this: collection(): insert(this: fields())
        return this
      })


  




