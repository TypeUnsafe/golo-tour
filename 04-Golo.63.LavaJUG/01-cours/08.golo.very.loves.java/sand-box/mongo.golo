module gongo

import org.k33g.alien.adapters

import com.mongodb.MongoClient
import com.mongodb.MongoException
import com.mongodb.WriteConcern
import com.mongodb.DB
import com.mongodb.DBCollection
import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import com.mongodb.DBCursor
import com.mongodb.ServerAddress


function main = |args| {

  let mongoClient = MongoClient("localhost", 27017 )
  let db = mongoClient:getDB("golodb")

  let coll = db:getCollection("goloCollection")

  let doc = BasicDBObject("name", "MongoDB")
    :append("type", "database")
    :append("count", 1)
    :append("info", BasicDBObject("x", 203):append("y", 102))

  let doc2 = BasicDBObject("name", "Redis")
    :append("type", "database")
    :append("count", 2)
    :append("info", BasicDBObject("x", 5):append("y", 5))

  coll:insert(doc)
  coll:insert(doc2)




}






