module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange

function main = |args| {

  let book = |id, title| -> DynamicObject(): title(title): id(id)


  let books = list[
      book("001", "A Princess of Mars")
    , book("002", "The Gods of Mars")
    , book("003", "The Chessmen of Mars")
  ]
  # server, static assets, all books, one book, add book, watch

  let server = HttpServer("localhost", 9000, |app| {
    
    app: static("/public", "index.html")

    app: $get("/books", |res, req| {
      res: json(books)
    })

    app: $get("/books/{id}", |res, req| {
      let id = req: params("id")
      res: json(books: find(|book| -> book: id(): equals(id)))
    })

    app: $post("/books", |res, req| {
      let data = req: json() 
      println(data)
      let id = uuid()
      books: add(book(
        id, 
        data: get("title")))
      
      res: redirect("/books/"+id, 301)
    })

  })
  
  server : start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
    events: each(|event| -> println(event: kind() + " " + event: context()))
    java.lang.System.exit(1)
  })



}