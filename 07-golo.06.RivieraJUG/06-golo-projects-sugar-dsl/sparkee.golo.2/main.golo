module sparkee_demo

import sparkee
import database

@post("/humans")
function createHuman = -> |req, res| {
  
  let human = map[
    ["id", uuid()], 
    ["firstName", req: data("firstName")],
    ["lastName", req: data("lastName")]
  ]

  Db(): add(human)
  return human # this is json
}

@get("/humans")
function allHumans = -> |req, res| -> Db()


@static("/public")
@port(8080)
function initializeWebApp = {
  # initialize used routes
  createHuman()
  allHumans()
}

function main = |args| {
  initializeWebApp()
}

