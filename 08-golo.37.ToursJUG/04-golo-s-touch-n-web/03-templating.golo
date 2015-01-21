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

# define template string
function booksViewTpl = ->
"""
<%@params books %>
  <style>
      body { background:#ffffff; font-size: 13px; color: #666666; font-family: Arial, helvetica, sans-serif;}
      h1 { color: #000000; }
  </style>
<h1>=== Books ===</h1>
<hr>
<ul>
  <% books: each(|book| { %>
    <li><h2> <%= book: title() %> </h2></li>
  <% }) %>
</u>
"""


function main = |args| {
  
  let books = list[
      Book("001", "A Princess of Mars")
    , Book("002", "The Gods of Mars"): remark("very good book")
    , Book("003", "The Chessmen of Mars")
  ]

  # compile template
  let booksView = gololang.TemplateEngine(): compile(booksViewTpl())

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    # --- get all books ---
    app: $get("/books", |res, req| {
      res: json(books)
    })

    # --- display all books with template ---
    app: $get("/books_page", |res, req| {
      res: html(
        booksView(books)
      )
    })


  })



  server: start(">>> http://localhost:"+ server: port() +"/")

  server: watch(["/"], |events| {
      events: each(|event| -> println(event: kind() + " " + event: context()))
      java.lang.System.exit(1)
  })
  

}