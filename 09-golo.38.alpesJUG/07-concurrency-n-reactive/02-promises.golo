module toujoursdespromesses

import gololang.Async
import http

function main = |args| {
  
  # define promise
  let books = -> promise(): initializeWithinThread(|resolve, reject| {
      let page = getHttp("http://localhost:9000/books", HTML())
      resolve(page)
  })

  # run promise
  books(): onSet(|result| { # if success
    println(result)
  }): onFail(|err| { # if failed
    println(err: getMessage())
  })
  

  println("=== the end ===")

}