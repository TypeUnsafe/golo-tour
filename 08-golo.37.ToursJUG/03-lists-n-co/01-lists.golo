module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange


function main = |args| {
  
  let books = list[
      "A Princess of Mars"
    , "The Gods of Mars"
    , "The Chessmen of Mars"
  ]

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    app: $get("/books", |res, req| {
      res: json(books)
    })

    app: $get("/books/{filter}", |res, req| {
      let filter = req:params("filter")
      # filtrer sur contains

      let r = books: filter(|item| -> 
          item: contains(filter))

      res: json(r)


    })

    app: $get("/display/books", |res, req| {
      let booksToHtml = list[]
      
      booksToHtml: add("<ul>")

      # add <li></li> with each book in books

      books: each(|item| -> 
        booksToHtml: add("<li>" + item + "</li>"))


      booksToHtml: add("</ul>")
      
      res: html(booksToHtml: join(""))
    })



    app: $get("/reverse/books", |res, req| {
      res: json(
        books: reverse()
      )
    })

    app: $get("/join/books", |res, req| {
      res: json(
        books: join("-")
      )
    })

  })

  server: start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
      events: each(|event| -> println(event: kind() + " " + event: context()))
      java.lang.System.exit(1)
  })
  

}