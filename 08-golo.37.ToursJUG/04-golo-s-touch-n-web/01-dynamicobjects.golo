module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange

----
"A Princess of Mars"
"The Gods of Mars"
"The Chessmen of Mars"
----
function main = |args| {
  
  let book1 = DynamicObject()
    : title("A Princess of Mars")

  let book2 = DynamicObject()
    : title("The Gods of Mars")

  let book3 = DynamicObject()
    : title("The Chessmen of Mars")

  let display = DynamicObject()
    : define("toHtml", |this| {
        return "<h2>" + 
          this: id() + " - " + 
          this: title() + " - " +
          this: remark() orIfNull "n/a" +
          "</h2>"
      })

  let books = list[book1, book2, book3]

  book1: mixin(display)
  book2: mixin(display)
  book3: mixin(display)

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    app: $get("/books", |res, req| {
      res: json(books)
    })

    app: $get("/add/id/to/books", |res, req| {
      book1: id("001")
      book2: id("002")
      book3: id("003"): remark("excellent")
      res: html("<h1>done</h1>")
    })    

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