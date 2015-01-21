module promises_always_promises

import com.mongodb.MongoClient
import com.mongodb.QueryBuilder
import gololang.Async
import gololang.concurrent.workers.WorkerEnvironment

function main = |args| {
  
  let env = WorkerEnvironment.builder(): withCachedThreadPool()
  
  # if result size > 0 ok else failed
  let mongoClient = MongoClient("localhost", 27017)
  let db = mongoClient: getDB("comics")
  let coll = db: getCollection("characters")


  # define promise
  let getresults = {
    
    return promise(): initialize(|resolve, reject| {

      env: spawn(|message| {
        let res = coll: find(QueryBuilder(): text("Spider"): get())
        #if res: size() > 0 { resolve(res) }
        #  else { reject(java.lang.Exception("Ouch!")) }
        if res: size() > 0 { resolve(res) } else { reject(java.lang.Exception("Ouch!")) }

        if message:equals("kill") {env: shutdown()}
      }): send("OK")

    })
  }

  # run promise
  getresults(): onSet(|result| { # if success
    result: each(|doc| -> println(doc: get("name")))
  }): onFail(|err| { # if failed
    println(err: getMessage())
  })

  println("Searching")

  env: shutdown()

}




