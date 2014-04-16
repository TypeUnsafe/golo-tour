module spark_demo

import spark
import humans.mongodb.models

function main = |args| {
  port(8002)

  let humans = Humans()

  GET("/", |request, response| {
    response: type("text/html")

    let html = """<%@params humansData %>
      <ul>
        <% humansData: each(|human| { %>
          <li><%= human: get("name") %> <%= human: get("age") %></li>
        <% }) %>
      </ul>
    """
    let template = gololang.TemplateEngine(): compile(html)

    return template(humans: fetch())
  })

}
