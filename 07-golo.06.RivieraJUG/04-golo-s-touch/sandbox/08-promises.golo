module promises_always_promises

import com.mongodb.MongoClient
import com.mongodb.QueryBuilder
import gololang.Async
import gololang.concurrent.workers.WorkerEnvironment

function main = |args| {
  
  let env = WorkerEnvironment.builder(): withCachedThreadPool()
  let mongoClient = MongoClient("localhost", 27017)
  let db = mongoClient: getDB("comics")
  let coll = db: getCollection("characters")
  # if result size > 0 ok else failed

  # define promise
  let getResult = {
    
    return promise(): initialize(|resolve, reject| {
      # doing something asynchronous
      env: spawn(|message| {
        
        let res = coll: find(QueryBuilder(): text("iron"): get())

        if res: size() > 0 { resolve(res) } else { reject(java.lang.Exception("Ouch!")) }

        if message:equals("kill") {env: shutdown()}
      }): send("go")
    })
  }


  # run promise
  getResult(): onSet(|result| { # if success
    result: each(|doc| -> println(doc: get("name")))
  }): onFail(|err| { # if failed
    println(err: getMessage())
  })

  println("searching ...")

  env: shutdown()

}




