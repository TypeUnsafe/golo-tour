module sparkee

# define template string
function booksViewTpl = ->
"""
<%@params books %>
  <style>
      body { background:#ffffff; font-size: 13px; color: #666666; font-family: Arial, helvetica, sans-serif;}
      h1 { color: #000000; }
  </style>
<h1>=== Books... ===</h1>
<hr>
<ul>
  <% books: each(|book| { %>
    <li><h2> <%= book: title() %> </h2></li>
  <% }) %>
</u>
"""

function view = |data| {
  # compile template
  let booksView = gololang.TemplateEngine(): compile(booksViewTpl())
  return booksView(data)
}