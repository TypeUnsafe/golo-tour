module main

import kiss
import kiss.request
import kiss.response
import kiss.httpExchange


# define template string
function booksViewTpl = ->
"""
<%@params books %>
  <style>
      body { 
          background:#ffffff
        ; font-size: 13px
        ; color: #666666
        ; font-family: Arial, helvetica, sans-serif
      }
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
  
  let book = |id, title| -> DynamicObject(): title(title): id(id)

  let books = list[
      book("001", "A Princess of Mars")
    , book("002", "The Gods of Mars")
    , book("003", "The Chessmen of Mars")
  ]

  # compile template
  let booksView = gololang.TemplateEngine(): compile(booksViewTpl())

  let server = HttpServer("localhost", 9000, |app| {

    app: static("/public", "index.html")

    # --- display all books with template ---
    app: $get("/books_page", |res, req| {
      res: html(
        booksView(books)
      )
    })

    # --- get all books ---
    app: $get("/books", |res, req| {
      res: json(books)
    })

  })

  server: start(">>> http://localhost:"+ server: port() +"/")


}