module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange

# httpserver
# static
# GET /hello -> json
# GET /hi -> html
# GET /hi/{who} -> html (req: params())
# restart

function main = |args| {

  let server = HttpServer("localhost", 9000, |app| {
    app: static("/public", "index.html")

    app: $get("/hello", |res, req| {
      res: json(message("Hello World"))
      
    })

    app: $get("/hi", |res, req| {
      res:html("<h1>ToursJUG</h1>")
      
    })

  })
  
  server : start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
    events: each(|event| -> println(event: kind() + " " + event: context()))
    java.lang.System.exit(1)
  })

}