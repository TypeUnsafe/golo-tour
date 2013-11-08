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

  let myDoc = coll:findOne() # find first
  
  println(myDoc)

  let cursor = coll:find()

  cursor: each(|doc|-> println(doc))
  cursor:close()

  let query = BasicDBObject("name", "Redis")
  
  coll:find(query):each(|doc|-> println("==> " + doc)):close()

  coll:find(BasicDBObject("info",BasicDBObject("x", 203):append("y",102))):each(|doc|-> println("##==> " + doc)):close()


}



