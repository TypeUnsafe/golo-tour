module spark_demo

import spark #(cf libs/spark.golo)

function main = |args| {

  port(8000)

  GET("/", |request, response| -> "Welcome!")

  GET("/hello", |request, response| -> "Hello World!")

  GET("/hello/:who", |request, response| -> 
    "Hello " + request: params(":who")
  )

}

