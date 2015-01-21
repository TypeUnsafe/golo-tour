module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange


function main = |args| {
  
  let books = map[
      ["001", "A Princess of Mars"]
    , ["002", "The Gods of Mars"]
    , ["003", "The Chessmen of Mars"]
  ]

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    app: $get("/books", |res, req| {
      res: json(books)
    })

    app: $get("/books/{id}", |res, req| {
      let id = req:params("id")

      res: html(
        "<h1>"+ books: get(id) +"</h1>"
      )
    })

  })

  server: start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
      events: each(|event| -> println(event: kind() + " " + event: context()))
      java.lang.System.exit(1)
  })
  

}