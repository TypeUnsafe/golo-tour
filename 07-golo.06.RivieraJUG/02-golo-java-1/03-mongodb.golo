module mongodb_is_awesome

import com.mongodb.MongoClient
#import com.mongodb.BasicDBObject
import com.mongodb.QueryBuilder

# cd /Users/k33g_org/Dropbox/Public/golo-riviera-jug
# mongod --dbpath=data/db  --port 27017

# database : comics
# collections : characters, ...
# use QueryBuilder

function main = |args| {

  let mongoClient = MongoClient("localhost", 27017)
  let db = mongoClient: getDB("comics")
  let coll = db: getCollection("characters")

  coll: find(QueryBuilder(): text("Spider"): get())
    : each(|doc| -> println(doc: get("description")))




}