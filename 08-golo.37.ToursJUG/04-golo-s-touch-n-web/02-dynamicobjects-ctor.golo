module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange

function Book = |id, title| {
  # constructor
  return DynamicObject(): title(title): id(id)
    : define("toHtml", |this| {
        return "<h2>" + 
          this: id() + " - " + 
          this: title() + " - " +
          this: remark() orIfNull "n/a" +
          "</h2>"
      })    
}

----
"A Princess of Mars"
"The Gods of Mars"
"The Chessmen of Mars"
----
function main = |args| {
  
  
  let books = list[
      Book("001", "A Princess of Mars")
    , Book("002", "The Gods of Mars"): remark("very good book")
    , Book("003", "The Chessmen of Mars")
  ]

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    # --- get all books ---
    app: $get("/books", |res, req| {
      res: json(books)
    })

    # --- get one book ---
    app: $get("/books/{id}", |res, req| {
      let id = req:params("id")
      res: html(
        books: find(|book| -> book: id(): equals(id)): toHtml()
      )
    })


  })







  server: start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
      events: each(|event| -> println(event: kind() + " " + event: context()))
      java.lang.System.exit(1)
  })
  

}