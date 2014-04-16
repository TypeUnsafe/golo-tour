module spark_demo

import spark
import jackson #(cf libs/jackson.golo)
import humans.mongodb.models

function main = |args| {
  port(8001)

  let json = Json()
  let humans = Humans()

  GET("/", |request, response| -> "<a href='humans'>All Humans</a>")

  GET("/humans", |request, response| {
    response: type("application/json")
    return Json(): toJsonString(humans: fetch())
  })

}
