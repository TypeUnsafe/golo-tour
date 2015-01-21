module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange

struct book = { 
  id,
  title
}

augment book {
  function toHtml = |this| {
    return "<h2>" + this: id() + " - " + this: title() + "</h2>"
  }
} 

struct books = { 
  list
}

augmentation collectionAbilities = {
  function getById = |this, id| {
    let model = this: list(): find(|item| -> item: id(): equals(id))
    println(model)
    return model
  }
}

augment books with collectionAbilities

----
"A Princess of Mars"
"The Gods of Mars"
"The Chessmen of Mars"
----
function main = |args| {
  
  let booksColl = books(list[
    book("001", "A Princess of Mars"),
    book("002", "The Gods of Mars"),
    book("003", "The Chessmen of Mars")
  ])

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    # --- get all books ---
    app: $get("/books", |res, req| {
      
      res: json(booksColl: list())
    })

    # --- get one book by id ---
    app: $get("/books/{id}", |res, req| {
      let id = req: params("id")

      res: html(booksColl: getById(id): toHtml())
    })

  })



  server: start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
      events: each(|event| -> println(event: kind() + " " + event: context()))
      java.lang.System.exit(1)
  })
  

}