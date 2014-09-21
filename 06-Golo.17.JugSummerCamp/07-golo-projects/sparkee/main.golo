module spark_demo

import sparkee

@get("/hi", html())
function hi =  -> |req, res| {
  return "<h1>HI!</h1>"
}

@get("/ola")
function ola =  -> |req, res| {
  let a = 5/0
  return "<h1>OLA!</h1>"
}

@get("/hello/:who", json())
function hello = -> |req, res| {
  return JSON.stringify(DynamicObject(): who(req: params(":who")))
}

@static("/public")
@port(8080)
function initializeWebApp = {
  # initialize used routes
  hi()
  hello()
  ola()
}

function main = |args| {
  initializeWebApp()
}

