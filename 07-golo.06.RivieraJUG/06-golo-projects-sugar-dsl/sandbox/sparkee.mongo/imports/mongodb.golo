module mongodb

import com.mongodb.MongoClient
import com.mongodb.BasicDBObject
import com.mongodb.QueryBuilder

let mongoClient = MongoClient("localhost", 27017)
let db = mongoClient: getDB("HumansDb")
let humansColl = db: getCollection("humans")


function getHumanCollection = -> humansColl

function HumanModel = |firstName, lastName| {
  let bo = BasicDBObject()
  bo: put("firstName", firstName)
  bo: put("lastName", lastName)

  return DynamicObject(): fields(bo)
    : define("insert", |this| {
        let res = getHumanCollection(): insert(this: fields())
        return this
      })
}

function HumansCollection = {
  return DynamicObject()
    : define("find", |this| {
        let humans = list[]
        getHumanCollection(): find(): each(|human| {
          let id = human: get("_id")
          human: put("_id", id: toString())
          humans: add((human: toMap()))
        })
        return humans
      })
}

  




