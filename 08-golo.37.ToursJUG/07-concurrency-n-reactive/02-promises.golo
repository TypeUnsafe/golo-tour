module toujoursdespromesses

import gololang.Async
import http

function main = |args| {
  
  # define promise
  let getbooks = {
    
    return promise(): initialize(|resolve, reject| {
      Thread({
        let page = getHttp(
          "http://localhost:9000", HTML())
        resolve(page: text())
      }): start()

    })
  }

  # run promise
  getbooks(): onSet(|result| { # if success
    println(result)
  }): onFail(|err| { # if failed
    println(err: getMessage())
  })



  println("=== the end ===")

}