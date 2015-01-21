#Lists

    app: $get("/books/{filter}", |res, req| {
      let filter = req:params("filter")
      res: json(
        books: filter(|item| -> item: contains(filter))
      )
    })

    app: $get("/display/books", |res, req| {
      let booksToHtml = list[]
      
      booksToHtml: add("<ul>")

      books: each(|book| {
        booksToHtml: add("<li>" + book + "</li>")
      })
      
      booksToHtml: add("</ul>")
      
      res: html(booksToHtml: join(""))
    })