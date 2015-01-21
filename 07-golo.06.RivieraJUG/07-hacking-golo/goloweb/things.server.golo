module things.server

import gololang.web

function main = |args| {
  
  let server = GoloHttpServer("localhost", 8081, |httpExchange| {
    httpExchange: response(JSON.stringify(map[
      ["message", "Hello World"],
      ["uri", httpExchange: uri(): toString(): split("/")]
   ]))
  })

  server: start()
  println(">>> http://localhost:8081/") 
}